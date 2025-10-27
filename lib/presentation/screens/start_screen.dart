import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/start/start.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          const Positioned.fill(child: BackgroundWidget()),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: height * 0.2,
                left: width * 0.1,
                child: const Text(
                  'хочу day off',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Positioned(
                top: height * 0.25,
                right: width * 0.1,
                child: const Text(
                  'хочу на море',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Positioned(
                top: height * 0.35,
                left: width * 0.1,
                child: const Text(
                  'хочу бутербродік',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Positioned(
                bottom: height * 0.35,
                left: width * 0.1,
                child: const Text(
                  'хочу спати',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Positioned(
                bottom: height * 0.25,
                right: width * 0.1,
                child: GestureDetector(
                  onTap: () => context.go(AppRoute.password.path),
                  child: const Text(
                    'Хочу олкеп в итйівУ',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
            ],
          )
              .animate(
                delay: 3.seconds,
                onPlay: (controller) => controller.repeat(),
              )
              .fadeIn(duration: 100.ms, curve: Curves.easeIn),
        ],
      ),
    );
  }
}
