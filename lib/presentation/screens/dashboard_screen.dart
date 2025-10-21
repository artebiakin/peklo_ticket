import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/dashboard/animated_ticket_button.dart';
import 'package:peklo_ticket/presentation/widgets/dashboard/support_float_button.dart';
import 'package:peklo_ticket/presentation/widgets/marquee_text.dart';
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

  bool isButtonLocked = false;

  void onTapCounter() async {
    if (isButtonLocked) return;

    if (tapCounter >= 4) {
      context.go(AppRoute.login.path);
      return;
    }

    setState(() {
      isButtonLocked = true;
      tapCounter++;
      infoMessage = switch (tapCounter) {
        1 => 'Tю.... ти серйозно?',
        2 => 'Воно тебі треба?',
        3 => 'Та побойся Бога!',
        _ => 'ну ти... зупинись вже!',
      };
    });

    if (!mounted) return;

    setState(() {
      isButtonLocked = false;
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
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
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
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Center(
                child:
                    Image.asset(image.dashboardImage.path, fit: BoxFit.cover),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _sloganContent
                  .mapIndexed(
                    (i, e) => MarqueeText(
                      text: e,
                      reverse: i.isEven,
                      speed: const Duration(seconds: 12),
                      gap: 40,
                      style: TextStyle(
                        color:
                            i.isEven ? const Color(0xFF4400FF) : Colors.white,
                        fontSize: 120,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                  .toList(),
            ),
            AnimatedTicketButton(
              onPressed: onTapCounter,
            ),
          ],
        ),
      );
    });
  }
}
