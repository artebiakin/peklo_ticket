import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:peklo_ticket/config/config.dart';

class OptionWidget extends StatelessWidget {
  final String leftOptionText;
  final String rightOptionText;

  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  const OptionWidget({
    super.key,
    this.onLeftTap,
    this.onRightTap,
    required this.leftOptionText,
    required this.rightOptionText,
  });

  @override
  Widget build(BuildContext context) {
    const hairHeight = 100.0;
    const morpheusHeight = 350.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          image.morpheus.path,
          height: morpheusHeight,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            image.hair.path,
            height: hairHeight,
          ),
        )
            .animate(
              onPlay: (controller) => controller.repeat(),
            )
            .then(delay: 2.seconds)
            .shake(duration: 1.seconds, hz: 1),
        Positioned(
          top: morpheusHeight * 0.25,
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: _Button(
                  onTap: onLeftTap,
                  text: leftOptionText,
                  bgColor: const Color(0xFFFD0000),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .then(delay: 0.5.seconds)
                    .shake(duration: 1500.ms, hz: 2),
              ),
              Flexible(
                child: _Button(
                  onTap: onRightTap,
                  text: rightOptionText,
                  bgColor: const Color(0xFF4400FF),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .then(delay: 0.5.seconds)
                    .shake(duration: 1500.ms, hz: 2),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final Color bgColor;

  final VoidCallback? onTap;

  const _Button({required this.text, required this.bgColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: Colors.white,
        backgroundColor: bgColor,
        minimumSize: const Size(100, 20),
        textStyle: const TextStyle(fontSize: 10),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
