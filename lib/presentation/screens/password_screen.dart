import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import 'package:peklo_ticket/config/config.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => context.go(AppRoute.dashboard.path),
      child: Material(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(images.passwordBg.path, fit: BoxFit.fitWidth),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Pinput(
                  onCompleted: (pin) => debugPrint(pin),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
