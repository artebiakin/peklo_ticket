import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/logo.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Logo(),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                'Упс .... пакєт був бракований і всі твої покупки загубились...',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 1800.ms),
              const Text(
                'Бо недарма люди кажуть:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ).animate().fadeIn(duration: 1800.ms, delay: 2800.ms),
            ],
          ),
          Image.asset(image.scaryGoastGroup.path)
              .animate(
                  delay: 4800.ms,
                  onPlay: (controller) =>
                      controller.repeat(count: 17, reverse: true))
              .scale(
                duration: 100.ms,
                begin: const Offset(0.8, 0.8),
                end: const Offset(1.0, 1.0),
              )
              .fadeIn(duration: 100.ms),
          const SizedBox.shrink(),
        ],
      ),
    );
  }
}
