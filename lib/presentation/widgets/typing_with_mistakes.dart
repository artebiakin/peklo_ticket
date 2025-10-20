import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:flutter_animate/flutter_animate.dart';

class TypingWithMistakes extends StatelessWidget {
  final String text;
  final Duration charSpeed; // per correct character
  final double errorProbability; // 0..1 chance to make a typo before a char
  final Duration mistakePause; // how long to stare at the typo
  final Duration backspaceSpeed; // how fast to erase the wrong char
  final TextStyle? style;
  final bool showCursor;
  final int? seed; // stable randomness across rebuilds

  final VoidCallback? onComplete;

  const TypingWithMistakes({
    super.key,
    required this.text,
    this.charSpeed = const Duration(milliseconds: 45),
    this.errorProbability = 0.18,
    this.mistakePause = const Duration(milliseconds: 280),
    this.backspaceSpeed = const Duration(milliseconds: 60),
    this.style,
    this.showCursor = true,
    this.seed,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final chars = text.characters.toList();
    final rnd = Random(seed ?? text.hashCode);

    // Build a frame script (string + duration per step)
    final frames = <_Frame>[];
    var buffer = Characters('');
    for (final c in chars) {
      final doMistake = _shouldMistake(c, errorProbability, rnd);
      if (doMistake) {
        final wrong = _wrongFor(c, rnd);
        // type wrong char
        buffer = Characters(buffer.toString() + wrong);
        frames.add(_Frame(buffer.toString(), charSpeed));
        // pause (staring at the error)
        frames.add(_Frame(buffer.toString(), mistakePause));
        // backspace the wrong char
        buffer = buffer.skipLast(1);
        frames.add(_Frame(buffer.toString(), backspaceSpeed));
      }
      // type correct char
      buffer = Characters(buffer.toString() + c);
      frames.add(_Frame(buffer.toString(), charSpeed));
    }

    final total =
        frames.fold<Duration>(Duration.zero, (a, f) => a + f.duration);

    // Render via a single flutter_animate CustomEffect
    final typed = Animate(
      onComplete: (_) {
        // ✅ Fire the callback when typing finishes
        if (onComplete != null) onComplete!();
      },
    ).custom(
      duration: total == Duration.zero ? 1.ms : total,
      builder: (_, value, __) {
        // map progress 0..1 to the right frame
        final targetMs = (total.inMilliseconds * value).round();
        var acc = 0;
        String shown = '';
        for (final f in frames) {
          acc += f.duration.inMilliseconds;
          if (targetMs <= acc) {
            shown = f.text;
            break;
          }
        }
        // edge case: at very end
        shown = shown.isEmpty ? text : shown;
        return Text(
          shown,
          style: style ?? DefaultTextStyle.of(context).style,
        );
      },
    );

    if (!showCursor) return typed;

    final baseStyle = style ?? DefaultTextStyle.of(context).style;
    final cursorHeight = (baseStyle.fontSize ?? 16) * 0.9;

    final cursor = SizedBox(width: 2, height: cursorHeight)
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .fadeIn(duration: 280.ms);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        typed,
        const SizedBox(width: 2),
        cursor,
      ],
    );
  }

  // Decide if we should make a typo for this character (avoid spaces/newlines)
  bool _shouldMistake(String c, double p, Random r) {
    if (c.trim().isEmpty) return false;
    return r.nextDouble() < p;
  }

  // Produce a wrong character that’s “plausible”
  String _wrongFor(String correct, Random r) {
    final pools = [
      'абвгґдеєжзиіїйклмнопрстуфхцчшщьюя', // UA lower
      'АБВГҐДЕЄЖЗИІЇЙКЛМНОПРСТУФХЦЧШЩЬЮЯ', // UA upper
      'abcdefghijklmnopqrstuvwxyz',
      'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
      '0123456789',
      ',.;:-!?',
    ];
    String pool = pools.firstWhere(
      (p) => p.contains(correct),
      orElse: () => pools[2], // default to latin lower
    );
    // ensure wrong != correct
    String candidate;
    do {
      candidate = pool[r.nextInt(pool.length)];
    } while (candidate == correct);
    return candidate;
  }
}

class _Frame {
  final String text;
  final Duration duration;
  _Frame(this.text, this.duration);
}
