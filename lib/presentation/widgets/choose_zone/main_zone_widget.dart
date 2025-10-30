import 'package:flutter/material.dart';
import 'package:peklo_ticket/config/config.dart';

class MainZoneWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const MainZoneWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        image.mainStage.path,
        fit: BoxFit.cover,
      ),
    );
  }
}
