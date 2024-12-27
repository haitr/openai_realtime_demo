import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

@riverpod
Stream<ConversationItemList> conversation(Ref ref, int scenarioId) async* {
  print('conversation');
  // openAI init
  final apiKey = dotenv.env['OPENAI'];
  final client = RealtimeClient(apiKey: apiKey);
  final resultStream = StreamController<ConversationItemList>();

  ref.onDispose(() async {
    print('conversation dispose');
    await client.disconnect();
    await resultStream.close();
  });

  // final aiPlayer = (await FlutterSoundPlayer().openPlayer())!;

  // await aiPlayer.startPlayerFromStream(
  //   codec: Codec.pcm16WAV,
  //   sampleRate: 24000,
  //   numChannels: 1,
  // );

  // Connect to Realtime API before setting up the conversation
  await client.connect();

  final scenario = await ref.read(scenarioProvider(scenarioId).future);
  await client.updateSession(instructions: scenario.content);
  await client.updateSession(voice: Voice.alloy);
  await client.updateSession(
    turnDetection: null,
    inputAudioTranscription: const InputAudioTranscriptionConfig(model: 'whisper-1'),
  );

  // Remove initial Hello message since we want to start with user's voice
  await client.sendUserMessageContent(const [ContentPart.text(text: 'Hello!')]);

  // Set up conversation event handling
  client.on(RealtimeEventType.conversationUpdated, (e) async {
    final event = e as RealtimeEventConversationUpdated;
    // final item = event.result.item?.item;
    final delta = event.result.delta;
    resultStream.add(client.conversation.items.values.toList());
    if (delta?.audio case var audio?) {
      // aiPlayer.foodSink?.add(FoodData(audio));
    }

    // if (item?.status == ItemStatus.completed && item?.formatted.audio.isNotEmpty == true) {
    //   // Handle completed audio if needed
    //   if (item?.role == 'assistant' && item?.formatted.transcript.contains('**End**') == true) {
    //     print('Conversation ended');
    //     client.disconnect();
    //   }
    // }
  });

  // Listen to audio stream without watch
  final audioBuffer = <int>[];
  const threshold = 8172;
  ref.listen(audioStreamProvider, (previous, next) {
    next.whenData((audioData) async {
      if (audioBuffer.length + audioData.length > threshold) {
        // print('appendInputAudio --- ${audioBuffer.length}');
        await client.appendInputAudio(Uint8List.fromList(audioBuffer));
        audioBuffer.clear();
      }
      audioBuffer.addAll(audioData);
    });
  });

  yield* resultStream.stream;
}
