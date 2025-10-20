import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/dashboard/animated_ticket_button.dart';
import 'package:peklo_ticket/presentation/widgets/dashboard/support_float_button.dart';
import 'package:peklo_ticket/presentation/widgets/widgets.dart';

const bgColor = Color(0xFF27E030);

const _sloganContent = [
  "Не знаєш що подарувати другові на день народження?",
  "Думаєш над тим, як привітати свого проджект менеджера?",
  "Хочеш мати впевненість в завтрашньому дні?",
  "Забронюй місце в пеклі вже сьогодні! ",
  "Не чекай до завтра, обирай просто зараз!",
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int tapCounter = 0;
  String infoMessage = '';

  void onTapCounter() {
    setState(() {
      tapCounter++;
      infoMessage = switch (tapCounter) {
        1 => 'Tю.... ти серйозно?',
        2 => 'Воно тебі треба?',
        3 => 'Та побойся Бога!',
        _ => 'ну ти... зупинись вже!',
      };
    });
  }

  Future<void> onInfoAnimationComplete() async {
    await Future.delayed(1.seconds);

    if (!mounted) return;

    setState(() {
      infoMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoute.login.path),
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Logo(),
        ),
        floatingActionButton: SupportFloatButton(
          infoMessage: infoMessage,
          onInfoAnimationComplete: onInfoAnimationComplete,
        ),
        body: Stack(
          children: [
            CupertinoPicker(
              itemExtent: 100,
              onSelectedItemChanged: (_) {},
              children: _sloganContent
                  .map((e) => Center(
                        child: Text(
                          e,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            AnimatedTicketButton(
              onPressed: onTapCounter,
            ),
          ],
        ),
      ),
    );
  }
}
