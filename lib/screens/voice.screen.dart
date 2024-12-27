import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openai_realtime_dart/openai_realtime_dart.dart';

import '../providers/providers.dart';

abstract class MessageItem extends StatelessWidget {
  final FormattedItem formattedItem;
  const MessageItem(this.formattedItem, {super.key});

  factory MessageItem.from(FormattedItem formattedItem) {
    debugPrint('message: ${formattedItem.item.type}');
    if (formattedItem.item case ItemMessage item) {
      return switch (item.role) {
        ItemRole.user => MyMessageItem(formattedItem, item),
        ItemRole.assistant => AiMessageItem(formattedItem, item),
        ItemRole.system => DefaultMessageItem(formattedItem),
      };
    }
    return DefaultMessageItem(formattedItem);
  }
}

class DefaultMessageItem extends MessageItem {
  const DefaultMessageItem(super.formattedItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      child: Text(formattedItem.item.type.toString(), style: const TextStyle(color: Colors.white)),
    );
  }
}

class MyMessageItem extends MessageItem {
  final ItemMessage item;

  const MyMessageItem(super.formattedItem, this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    // item.content.map((e) => print(e.type)).toList();
    // return Column(
    //   children: item.content
    //       .map(
    //         (e) => Text(e.text),
    //       )
    //       .toList(),
    // );
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(formattedItem.formatted?.text ?? ''),
    );
  }
}

class AiMessageItem extends MessageItem {
  final ItemMessage item;

  const AiMessageItem(super.formattedItem, this.item, {super.key});

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
                itemBuilder: (context, index) => MessageItem.from(conversation[index]),
                itemCount: conversation.length,
              ),
            ),
      ),
    );
  }
}
