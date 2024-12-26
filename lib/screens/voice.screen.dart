import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

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
                itemBuilder: (context, index) {
                  final item = conversation[index];
                  return Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(item.formatted?.text ?? ''),
                  );
                },
                itemCount: conversation.length,
              ),
            ),
      ),
    );
  }
}
