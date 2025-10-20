import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class SmoothCircularAnimation extends HookWidget {
  final Widget child;
  final double radius; // circle radius in px
  final Duration period; // time for one full lap
  final bool clockwise;
  final Alignment center; // center of the circle inside the parent
  final Curve curve; // easing of angular velocity (optional)

  const SmoothCircularAnimation({
    super.key,
    required this.child,
    this.radius = 80,
    this.period = const Duration(seconds: 3),
    this.clockwise = true,
    this.center = Alignment.center,
    this.curve = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: period)
      ..repeat(); // continuous loop

    // Optionally ease the angle with a curve
    final anim = useMemoized(
      () => CurvedAnimation(parent: controller, curve: curve),
      [controller, curve],
    );

    // Listen each tick
    useListenable(anim);

    // 0..1 -> angle 0..2π
    final theta = (clockwise ? 1 : -1) * 2 * math.pi * anim.value;
    final dx = radius * math.cos(theta);
    final dy = radius * math.sin(theta);

    // Place the orbit center using an Align, then translate relative to that
    return Transform.translate(
      offset: Offset(dx, dy),
      child: child,
    );
  }
}
