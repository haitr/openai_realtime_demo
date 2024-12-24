import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'screens/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const ProviderScope(child: MainApp()));
}

final _router = GoRouter(
  initialLocation: '/scenarios',
  routes: [
    GoRoute(
      path: '/scenarios',
      builder: (context, state) => ScenarioScreen(),
      routes: [
        GoRoute(
          path: '/voice',
          builder: (context, state) => VoiceScreen(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.router(
      title: 'OpenAI Demo',
      routerConfig: _router,
    );
  }
}
