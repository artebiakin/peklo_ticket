import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/start/start.dart';
import 'package:peklo_ticket/services/services.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    playSound();
    super.initState();
  }

  @override
  void dispose() {
    AudioplayersService().stopBgm();
    super.dispose();
  }

  void playSound() async {
    await Future.delayed(const Duration(seconds: 3));
    AudioplayersService().playBgm(audio.aMp3________, volume: 0.1);
  }

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
                  onTap: () {
                    AudioplayersService().stopBgm();
                    context.go(AppRoute.password.path);
                  },
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
