import 'package:flutter/material.dart';
import 'package:peklo_ticket/config/config.dart';

class FanZone1Widget extends StatelessWidget {
  final VoidCallback? onTap;

  const FanZone1Widget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        image.fanZone1.path,
        fit: BoxFit.contain,
      ),
    );
  }
}
