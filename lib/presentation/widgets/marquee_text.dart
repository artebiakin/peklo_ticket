import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Seamless marquee (ticker) using flutter_animate + hooks.
/// reverse: true  → right → left
/// reverse: false → left  → right
class MarqueeText extends HookWidget {
  const MarqueeText({
    super.key,
    required this.text,
    this.reverse = true,
    this.speed = const Duration(seconds: 8),
    this.gap = 32.0,
    this.style,
    this.width,
  });

  final String text;
  final bool reverse;
  final Duration speed; // time to shift by one "distance"
  final double gap; // spacing between copies
  final TextStyle? style;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = (style ?? DefaultTextStyle.of(context).style)
        .copyWith(overflow: TextOverflow.visible);
    final textDir = Directionality.of(context);

    // Measure real text width for perfect loop distance
    final textSize = useMemoized(() {
      final tp = TextPainter(
        text: TextSpan(text: text, style: effectiveStyle),
        maxLines: 1,
        textDirection: textDir,
      )..layout();
      return tp.size;
    }, [
      text,
      effectiveStyle,
      textDir,
      MediaQuery.of(context).devicePixelRatio
    ]);

    final distance = textSize.width + gap;

    // Move left if reverse==true, else right
    const begin = 0.0;
    final end = reverse ? -distance : distance;

    return LayoutBuilder(builder: (context, constraints) {
      final viewportWidth = width ?? constraints.maxWidth;

      return ClipRect(
        child: SizedBox(
          width: viewportWidth,
          height: textSize.height,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // Strip A
              _Strip(
                left: reverse ? 0.0 : -distance,
                text: text,
                style: effectiveStyle,
                begin: begin,
                end: end,
                duration: speed,
              ),
              // Strip B (starts right after A)
              _Strip(
                left: reverse ? distance : 0.0,
                text: text,
                style: effectiveStyle,
                begin: begin,
                end: end,
                duration: speed,
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _Strip extends StatelessWidget {
  const _Strip({
    required this.left,
    required this.text,
    required this.style,
    required this.begin,
    required this.end,
    required this.duration,
  });

  final double left;
  final String text;
  final TextStyle style;
  final double begin;
  final double end;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: 0,
      bottom: 0,
      child: RepaintBoundary(
        child: Text(text, maxLines: 1, style: style)
            .animate(onPlay: (controller) => controller.repeat())
            .moveX(
              begin: begin,
              end: end,
              duration: duration,
              curve: Curves.linear,
            ),
      ),
    );
  }
}
