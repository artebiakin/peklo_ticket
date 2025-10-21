import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/login/complete_widget.dart';
import 'package:peklo_ticket/presentation/widgets/login/login_error.dart';
import 'package:peklo_ticket/presentation/widgets/login/option_widget.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentState = useState(_LoginState.firstQuest);
    final completeController = useAnimationController();

    void onErrorState() {
      currentState.value = _LoginState.error;
    }

    void onAcknowledged() {
      currentState.value = _LoginState.secondQuest;
    }

    void onCompleted() {
      currentState.value = _LoginState.completed;
    }

    void onChooseZone() {
      context.go(AppRoute.chooseZone.path);
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            child: OptionWidget(
              leftOptionText: 'Зорі прозорі вгорі,\nвам спицця чи не спицця',
              rightOptionText: 'Танцуй тьотя, атятя',
              onLeftTap: onErrorState,
              onRightTap: onErrorState,
            ),
          )
              .animate(
                  target: currentState.value == _LoginState.firstQuest ? 1 : 0)
              .scale(duration: 500.ms)
              .fadeIn(duration: 500.ms),
          Positioned.fill(
            child: LoginError(onAcknowledged: onAcknowledged)
                .animate(
                    target: currentState.value == _LoginState.error ? 1 : 0)
                .then(delay: 500.ms)
                .flip(duration: 100.ms)
                .scale(duration: 200.ms, curve: Curves.bounceOut),
          ),
          FittedBox(
            child: OptionWidget(
              leftOptionText: 'А липи цвітуть,\nдухмяні, духмяні',
              rightOptionText: 'На могилі моїй\nпосадіть молоду яворииину',
              onLeftTap: onCompleted,
              onRightTap: onCompleted,
            ),
          )
              .animate(
                  target: currentState.value == _LoginState.secondQuest ? 1 : 0)
              .scale(duration: 500.ms)
              .fadeIn(duration: 500.ms),
          Positioned.fill(
            child: CompleteWidget(
              onTap: onChooseZone,
              controller: completeController,
            ),
          )
              .animate(
                controller: completeController,
                target: currentState.value == _LoginState.completed ? 1 : 0,
              )
              .scale(delay: 0.seconds)
              .saturate(duration: 15.seconds)
              .fadeIn(duration: 15.seconds),
          if (currentState.value == _LoginState.completed)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: ValueListenableBuilder(
                  valueListenable: completeController,
                  builder: (context, value, child) => LinearProgressIndicator(
                    backgroundColor: Colors.black,
                    value: 1 - completeController.value,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

enum _LoginState { firstQuest, error, secondQuest, completed }
