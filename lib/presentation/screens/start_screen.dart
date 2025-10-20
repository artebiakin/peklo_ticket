import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/start/start.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onDoubleTap: () => context.go(AppRoute.password.path),
        child: const Stack(
          children: [
            Positioned.fill(child: BackgroundWidget()),
          ],
        ),
      ),
    );
  }
}
