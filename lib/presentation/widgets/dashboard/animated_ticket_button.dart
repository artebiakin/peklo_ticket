import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:peklo_ticket/config/config.dart';

typedef ButtonPosition = ({
  double? top,
  double? bottom,
  double? left,
  double? right,
  double? angle,
  Offset animateBegin
});

class AnimatedTicketButton extends HookWidget {
  const AnimatedTicketButton({super.key, this.onPressed})
      : _buttonPositions = const [
          (
            top: null,
            bottom: 0,
            left: 0,
            right: null,
            angle: 0.25,
            animateBegin: Offset(-200, 200),
          ),
          (
            top: null,
            bottom: 0,
            left: null,
            right: 0,
            angle: -0.25,
            animateBegin: Offset(200, 200)
          ),
          (
            top: 0,
            bottom: null,
            left: null,
            right: 0,
            angle: 1.25,
            animateBegin: Offset(200, -200),
          ),
          (
            top: 0,
            bottom: null,
            left: 0,
            right: null,
            angle: -1.25,
            animateBegin: Offset(-200, -200),
          ),
        ];

  final VoidCallback? onPressed;

  final List<ButtonPosition> _buttonPositions;

  @override
  Widget build(BuildContext context) {
    final buttonPosition = useState(_buttonPositions[0]);
    final defaultAnimationPosition = Offset(
        buttonPosition.value.animateBegin.dx * 0.1,
        buttonPosition.value.animateBegin.dy * 0.1);

    return Positioned(
      top: buttonPosition.value.top,
      bottom: buttonPosition.value.bottom,
      left: buttonPosition.value.left,
      right: buttonPosition.value.right,
      child: GestureDetector(
        onTap: onPressed,
        child: Transform.rotate(
          angle: buttonPosition.value.angle! * math.pi,
          child: Image.asset(images.ticket.path),
        ),
      ),
    )
        .animate(
          onComplete: (controller) {
            buttonPosition.value = _buttonPositions[
                math.Random().nextInt(_buttonPositions.length)];
            controller.reset();
            controller.forward();
          },
        )
        .move(
          duration: 1500.ms,
          curve: Curves.easeInOut,
          begin: buttonPosition.value.animateBegin,
          end: defaultAnimationPosition,
        )
        .then()
        .shake(duration: 500.ms, hz: 10)
        .then()
        .move(
          duration: 1500.ms,
          curve: Curves.easeInOut,
          begin: defaultAnimationPosition,
          end: buttonPosition.value.animateBegin,
        );
  }
}
