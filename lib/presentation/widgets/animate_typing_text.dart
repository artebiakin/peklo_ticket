import 'package:flutter/cupertino.dart';

import 'package:flutter_animate/flutter_animate.dart';

class AnimateTypingText extends StatelessWidget {
  final String text;
  final Duration charSpeed;
  final TextStyle? style;
  final bool showCursor;

  const AnimateTypingText({
    super.key,
    required this.text,
    this.charSpeed = const Duration(milliseconds: 40),
    this.style,
    this.showCursor = true,
  });

  @override
  Widget build(BuildContext context) {
    final chars = text.characters;
    final total = chars.length;
    final duration = charSpeed * (total == 0 ? 1 : total);

    // The typing effect itself
    final typed = Animate().custom(
      duration: duration,
      builder: (_, value, __) {
        final count = (value * total).clamp(0, total).floor();
        final visible = chars.take(count).toString();
        return Text(
          visible,
          style: style ?? DefaultTextStyle.of(context).style,
        );
      },
    );

    if (!showCursor) return typed;

    // A simple blinking cursor that loops
    final cursor = SizedBox(width: 2, height: (style?.fontSize ?? 16) * 0.9)
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .fadeIn(duration: 300.ms);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        typed,
        const SizedBox(width: 2),
        cursor, // blinks while typing (and after)
      ],
    );
  }
}
