import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../models/prompt.model.dart';
import '../providers/providers.dart';

class ScenarioScreen extends ConsumerWidget {
  const ScenarioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Scenarios'),
        ),
        body: ListView.custom(
          padding: EdgeInsets.all(16),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              return ref.watch(scenarioNotifierProvider).whenOrNull(
                data: (data) {
                  if (index >= data.length) return null;
                  final item = data[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Expanded(
                        child: ShadAccordion<Scenario>(
                          children: [
                            ShadAccordionItem(
                              value: item,
                              title: Text(item.title),
                              child: Text(item.content),
                            ),
                          ],
                        ),
                      ),
                      ShadButton(
                        child: const Text('Go'),
                        onPressed: () {
                          context.push('/scenarios/voice');
                        },
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: ShadButton(
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {},
        ));
  }
}
