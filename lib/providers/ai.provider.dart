import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_realtime_dart/openai_realtime_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'scenario.provider.dart';

part 'ai.provider.g.dart';

typedef ConversationItemList = List<FormattedItem>;

@riverpod
Stream<ConversationItemList> conversation(Ref ref, int scenarioId) async* {
  final apiKey = dotenv.env['OPENAI'];
  final client = RealtimeClient(apiKey: apiKey);
  final resultStream = StreamController<ConversationItemList>();

  ref.onDispose(() => client.disconnect());

  final scenario = await ref.read(scenarioProvider(scenarioId).future);

  await client.updateSession(instructions: scenario.content);
  await client.updateSession(voice: Voice.alloy);
  await client.updateSession(
    turnDetection: null,
    inputAudioTranscription: const InputAudioTranscriptionConfig(model: 'whisper-1'),
  );

  // Set up event handling
  client.on(RealtimeEventType.conversationUpdated, (e) {
    // final event = e as RealtimeEventConversationUpdated;
    // final item = event.result.item;
    // final delta = event.result.delta; // delta can be null or populated
    resultStream.add(client.conversation.items.values.toList());
  });

  // Connect to Realtime API
  await client.connect();

  // Send a item and triggers a generation
  await client.sendUserMessageContent(const [
    ContentPart.text(text: '안녕하세요!'),
  ]);

  yield* resultStream.stream;
}
