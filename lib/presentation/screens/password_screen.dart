import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart' hide svg;
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/password/overlay_widget.dart';
import 'package:peklo_ticket/presentation/widgets/password/svg_shape.dart';
import 'package:peklo_ticket/services/services.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final pinController = TextEditingController();

  String message = '';
  bool isSuccess = false;
  bool showOverlay = false;
  bool showTip = false;
  int counterErrors = 0;

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  void onPasswordComplete(String pin) {
    if (pin == '969' || pin == '666') {
      setState(() {
        message = '';
      });
      context.go(AppRoute.dashboard.path);
      AudioplayersService().playSfx(audio.aMp3__________, volume: 1);
    } else {
      pinController.clear();
      setState(() {
        counterErrors++;
        message = switch (counterErrors) {
          1 => () {
              AudioplayersService().playSfx(audio.aMp3_____, volume: 1);
              return 'Дев’ять чи\nдесять?';
            }(),
          2 => () {
              AudioplayersService().playSfx(audio.aMp3____________, volume: 1);
              return 'не чує баба...';
            }(),
          3 => () {
              AudioplayersService().playSfx(audio.aMp3_, volume: 1);
              return 'Без пятнадцяти \nдесять?';
            }(),
          4 => '',
          _ => 'все ще нєт, \nдумай далі',
        };
        if (counterErrors == 4) {
          showOverlay = true;
        }
      });
    }
  }

  void onShowTip() {
    setState(() {
      showOverlay = false;
      showTip = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(image.passwordBg.path, fit: BoxFit.fitWidth),
          ),
          SvgPicture.asset(svg.password),
          Positioned(
            top: 100,
            bottom: 0,
            right: 0,
            child: Center(
              child: SvgShape(
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(left: 44),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Color(0xFF5D9D60),
                    ),
                  ),
                ),
              ),
            ),
          )
              .animate(target: message.isEmpty ? 0 : 1)
              .fadeIn(duration: 600.ms, curve: Curves.easeOut)
              .scale(duration: 200.ms, curve: Curves.easeOut),

          const Positioned(
            top: 0,
            bottom: 0,
            child: Center(
              child: Text(
                '666',
                style: TextStyle(fontSize: 24, color: Colors.white12),
              ),
            ),
          )
              .animate(
                target: showTip ? 1 : 0,
              )
              .fadeIn(),
          Positioned(
            top: 100,
            bottom: 0,
            right: 0,
            child: Center(
              child: SvgShape(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0).copyWith(left: 24),
                  child: const Text(
                    'заходь',
                    style: TextStyle(
                      fontSize: 34,
                      color: Color(0xFF5C5C5C),
                    ),
                  ),
                ),
              ),
            ),
          )
              .animate(target: isSuccess ? 1 : 0)
              .fadeIn(duration: 600.ms, curve: Curves.easeOut)
              .scale(duration: 200.ms, curve: Curves.easeOut),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Pinput(
                length: 3,
                controller: pinController,
                defaultPinTheme: PinTheme(
                    constraints:
                        const BoxConstraints(maxHeight: 120, maxWidth: 120),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red),
                    ),
                    textStyle:
                        const TextStyle(fontSize: 60, color: Colors.red)),
                onCompleted: onPasswordComplete,
              ),
            ),
          ),

          //
          if (showOverlay)
            Positioned.fill(
              child: OverlayWidget(
                onTap: onShowTip,
              ),
            ).animate(target: showOverlay ? 1 : 0).fadeIn(),
        ],
      ),
    );
  }
}
