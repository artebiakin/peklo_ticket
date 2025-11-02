import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';

class FanZone2Widget extends StatelessWidget {
  const FanZone2Widget({
    super.key,
  });

  void onTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Що на вас очікує в фанзоні 2:',
              textAlign: TextAlign.right,
            ),
            content: const Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                Text("Лекція іллі ківи “Я малінький гвінтік”"),
                Text("Естафета “Веселі старти - хто перший збере свій скелет”"),
                Text(
                    "Ток-шоу “Іспанський сором” - прослуховування висловів Віталія Кличко"),
                Text(
                    "Speaking club “Галя” - повторення теми “Утворення іменників” (салатес, олівес, олів’єтес)"),
                Text("Олімпійські змагання з “Метання стегнової кістки”"),
                Text("Волонтерський проект: “Відріж язик колаборанту”"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => context.go(AppRoute.completeChooseZone.path),
                child: const Text('Хачу}'),
              ),
              TextButton(
                onPressed: context.pop,
                child: const Text('не, дякую'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Image.asset(
        image.fanZone2.path,
        fit: BoxFit.cover,
      ),
    );
  }
}
