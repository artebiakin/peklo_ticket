import 'package:flutter/material.dart';

class SvgShape extends StatelessWidget {
  const SvgShape({
    super.key,
    this.color = const Color(0xFFFD0000),
    this.child,
  });

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(400, 150),
      painter: _RedShapePainter(color),
      child: FittedBox(child: child),
    );
  }
}

class _RedShapePainter extends CustomPainter {
  _RedShapePainter(this.color);

  final Color color;

  static const double _viewW = 314.0;
  static const double _viewH = 144.0;

  @override
  void paint(Canvas canvas, Size size) {
    // Scale the original 314x144 viewBox to whatever size is provided.
    canvas.save();
    canvas.scale(size.width / _viewW, size.height / _viewH);

    final path = Path()
      ..moveTo(58.0998, 95.457)
      ..lineTo(0, 144)
      ..lineTo(82.58, 127.71)
      ..lineTo(314, 127.71)
      ..lineTo(314, 0)
      ..lineTo(58.0998, 0)
      ..lineTo(58.0998, 95.457)
      ..close();

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RedShapePainter oldDelegate) =>
      oldDelegate.color != color;
}
