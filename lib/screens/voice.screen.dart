import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_realtime_dart/openai_realtime_dart.dart';

import '../providers/providers.dart';

abstract class MessageItem extends StatelessWidget {
  final Item item;

  const MessageItem(this.item, {super.key});

  factory MessageItem.from(Item item) {
    if (item case ItemMessage item) {
      return switch (item.role) {
        ItemRole.user => MyMessageItem(item),
        ItemRole.assistant => AiMessageItem(item),
        ItemRole.system => DefaultMessageItem(item),
      };
    }
    return DefaultMessageItem(item);
  }
}

class DefaultMessageItem extends MessageItem {
  const DefaultMessageItem(super.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      child: Text(item.type.toString()),
    );
  }
}

class MyMessageItem extends MessageItem {
  const MyMessageItem(super.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(item.type.toString()),
    );
  }
}

class AiMessageItem extends MessageItem {
  const AiMessageItem(super.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(item.type.toString(), style: const TextStyle(color: Colors.white)),
    );
  }
}

class VoiceScreen extends ConsumerWidget {
  final int scenarioId;
  const VoiceScreen({super.key, required this.scenarioId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice'),
      ),
      body: SafeArea(
        child: ref.watch(conversationProvider(scenarioId)).maybeWhen(
              orElse: () => const Center(child: CircularProgressIndicator()),
              data: (conversation) => ListView.builder(
                itemBuilder: (context, index) => MessageItem.from(conversation[index].item),
                itemCount: conversation.length,
              ),
            ),
      ),
    );
  }
}
