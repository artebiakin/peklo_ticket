import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:peklo_ticket/config/config.dart';

class BackgroundWidget extends StatefulWidget {
  const BackgroundWidget({super.key});

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget> {
  final imageSource = [
    image.a1StartScreen.path,
    image.a1StartScreenWithClip.path,
  ];
  int get randomRepeatCount => math.Random().nextInt(6) + 3;

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      Image.asset(
        image.a1StartScreen.path,
        fit: BoxFit.cover,
      ),
      Image.asset(
        image.a1StartScreenWithClip.path,
        fit: BoxFit.cover,
      )
          .animate(
            delay: 3.seconds,
            onPlay: (controller) => controller.repeat(count: randomRepeatCount),
            onComplete: (controller) async {
              await Future.delayed(2.seconds);
              if (mounted) controller.repeat(count: randomRepeatCount);
            },
          )
          .fadeIn(duration: 50.ms, curve: Curves.easeIn)
          .then(delay: 100.ms)
          .fadeOut(duration: 50.ms, curve: Curves.easeOut)
    ]);
  }
}
