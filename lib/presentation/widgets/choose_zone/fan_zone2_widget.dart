import 'package:flutter/material.dart';
import 'package:peklo_ticket/config/config.dart';

class FanZone2Widget extends StatelessWidget {
  final VoidCallback? onTap;

  const FanZone2Widget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        image.fanZone2.path,
        fit: BoxFit.cover,
      ),
    );
  }
}
