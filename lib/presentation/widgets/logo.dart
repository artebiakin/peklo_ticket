import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:peklo_ticket/config/config.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      images.logo.path,
      fit: BoxFit.cover,
    )
        .animate(
          onPlay: (c) => c.loop(reverse: true),
        )
        .custom(
          duration: 600.ms,
          builder: (_, value, child) {
            final color = Color.lerp(Colors.red, Colors.yellow, value)!;

            return ColorFiltered(
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              child: child,
            );
          },
        );
  }
}
