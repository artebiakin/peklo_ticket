import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/typing_with_mistakes.dart';

class SupportFloatButton extends StatelessWidget {
  static const double positionOffset = 6.0;

  final String infoMessage;
  final VoidCallback onInfoAnimationComplete;

  const SupportFloatButton({
    super.key,
    required this.infoMessage,
    required this.onInfoAnimationComplete,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: Colors.black,
      icon: Image.asset(image.support.path),
      label: Stack(
        children: [
          const Text(
            "На зв’язку ваш менеджер Дуся",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ).animate(target: infoMessage.isEmpty ? 1 : 0).fadeIn(),
          if (infoMessage.isNotEmpty)
            Row(
              children: [
                const Text(
                  'Дуся: ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TypingWithMistakes(
                  key: Key(infoMessage),
                  onComplete: onInfoAnimationComplete,
                  text: infoMessage.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
