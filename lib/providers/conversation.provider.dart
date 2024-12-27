import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:logger/src/log_level.dart';
import 'package:openai_realtime_dart/openai_realtime_dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'scenario.provider.dart';

part 'conversation.provider.g.dart';

typedef ConversationItemList = List<FormattedItem>;

@riverpod
Stream<Uint8List> audioStream(Ref ref) async* {
  if (await Permission.microphone.request().isGranted) {
    final recorder = AudioRecorder();

    ref.onDispose(() async {
      await recorder.cancel();
      await recorder.dispose();
    });

    final stream = await recorder.startStream(
      RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 24000, numChannels: 1),
    );

    yield* stream;
  }
}

@Riverpod(keepAlive: true)
class Player extends _$Player {
  final _player = FlutterSoundPlayer(logLevel: Level.off);

  @override
  Player build() {
    ref.onDispose(() {
      _player.closePlayer();
    });
    _player.openPlayer();
    return this;
  }

  Future<void> playAudio(Uint8List bytes) async {
    final duration =
        await _player.startPlayer(fromDataBuffer: bytes, sampleRate: 24000, codec: Codec.pcm16);
    debugPrint('duration: $duration');
  }

  Future<void> stop() async {
    await _player.stopPlayer();
  }
}

@riverpod
Stream<ConversationItemList> conversation(Ref ref, int scenarioId) async* {
  debugPrint('conversation');
  // openAI init
  final apiKey = dotenv.env['OPENAI'];
  final client = RealtimeClient(apiKey: apiKey);
  final resultStream = StreamController<ConversationItemList>();

  ref.onDispose(() async {
    debugPrint('conversation dispose');
    await client.disconnect();
    await resultStream.close();
  });

  // Connect to Realtime API before setting up the conversation
  await client.connect();

  final scenario = await ref.read(scenarioProvider(scenarioId).future);
  await client.updateSession(instructions: scenario.content);
  await client.updateSession(voice: Voice.alloy);
  await client.updateSession(
    turnDetection: null,
    inputAudioTranscription: const InputAudioTranscriptionConfig(model: 'whisper-1'),
  );

  final player = ref.read(playerProvider);

  // Set up conversation event handling
  client.on(RealtimeEventType.conversationUpdated, (e) async {
    debugPrint('conversationUpdated');
    final event = e as RealtimeEventConversationUpdated;
    // final item = event.result.item?.item;
    resultStream.add(client.conversation.items.values.toList());
    if (event.result.item?.formatted?.audio case var bytes?) {
      await player.playAudio(bytes);
    }

    // if (item?.status == ItemStatus.completed && item?.formatted.audio.isNotEmpty == true) {
    //   // Handle completed audio if needed
    //   if (item?.role == 'assistant' && item?.formatted.transcript.contains('**End**') == true) {
    //     print('Conversation ended');
    //     client.disconnect();
    //   }
    // }
  });
  client.on(RealtimeEventType.conversationInterrupted, (e) async {
    debugPrint('conversationInterrupted');
    await player.stop();
  });

  // Listen to audio stream
  final audioBuffer = <int>[];
  const threshold = 8172;
  ref.listen(audioStreamProvider, (previous, next) {
    next.whenData((audioData) async {
      if (audioBuffer.length + audioData.length > threshold) {
        // debugPrint('appendInputAudio --- ${audioBuffer.length}');
        await client.appendInputAudio(Uint8List.fromList(audioBuffer));
        audioBuffer.clear();
      }
      audioBuffer.addAll(audioData);
    });
  });

  // Remove initial Hello message since we want to start with user's voice
  await client.sendUserMessageContent(const [ContentPart.text(text: 'Hello!')]);

  yield* resultStream.stream;
}
