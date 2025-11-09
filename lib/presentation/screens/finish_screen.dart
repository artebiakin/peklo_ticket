import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/logo.dart';
import 'package:peklo_ticket/services/services.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  State<FinishScreen> createState() => _FinishScreenState();
}

class _FinishScreenState extends State<FinishScreen> {
  @override
  void initState() {
    playSound();
    super.initState();
  }

  void playSound() async {
    await Future.delayed(4800.ms);
    AudioplayersService().playSfx(audio.aMp3_________, volume: 1);
  }

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
          Transform.rotate(
            angle: -0.05,
            child: BackToNightmaresButton(
              onPressed: () => context.go(AppRoute.start.path),
            ),
          )
              .animate()
              .fade(
                delay: 7.seconds,
              )
              .animate(
                onPlay: (controller) => controller.repeat(reverse: true),
              )
              .rotate(
                duration: 600.ms,
                curve: Curves.easeInOut,
              )
              .shake(
                duration: 600.ms,
                hz: 4,
              ),
        ],
      ),
    );
  }
}

class BackToNightmaresButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BackToNightmaresButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        painter: _ButtonPainter(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Center(
            child: Text(
              '← НАЗАД ДО КОШМАРІВ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Colors.cyanAccent, Colors.yellowAccent],
                  ).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 3,
                  ),
                ],
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

    // Неонова тінь
    final glowPaint = Paint()
      ..color = Colors.greenAccent.withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15);
    canvas.drawRRect(rrect, glowPaint);

    // Основний фон із градієнтом
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF00FF00), Color(0xFFEE00FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);
    canvas.drawRRect(rrect, bgPaint);

    // Рамка в стилі чорно-рожевого патерну
    const borderWidth = 6.0;
    const step = 12.0;
    final path = Path()..addRRect(rrect);
    final borderPaint = Paint()
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    for (double i = 0; i < size.width + size.height * 2; i += step) {
      borderPaint.color = i ~/ step % 2 == 0 ? Colors.black : Colors.pink;
      canvas.drawPath(path, borderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
