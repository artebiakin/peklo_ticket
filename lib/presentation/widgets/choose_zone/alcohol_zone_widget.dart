import 'package:flutter/material.dart';
import 'package:peklo_ticket/config/config.dart';

class AlcoholZoneWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const AlcoholZoneWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        image.alcoholCoctailZone.path,
        fit: BoxFit.contain,
      ),
    );
  }
}
