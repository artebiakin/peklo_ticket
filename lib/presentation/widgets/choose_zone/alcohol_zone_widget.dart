import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';

class AlcoholZoneWidget extends StatelessWidget {
  const AlcoholZoneWidget({super.key});

  void onTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Що на вас очікує в зоні алкогольних коктейлів:',
              textAlign: TextAlign.right,
            ),
            content: const Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                Text("Безкоштовні алкогольні коктейлі:"),
                Text("“Дизельний”"),
                Text("“Пікантний” з екстрактом заспиртованої чупакабри"),
                Text("“Апероль-шпріц наркомана”"),
                Text("“Блю Шмарклясао”"),
                Text(
                    "“Піна Колада це був випадок Піна Колада ти мій виняток Я тебе всю до дна”"),
                Text("“Чмохіто”"),
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
        image.alcoholCoctailZone.path,
        fit: BoxFit.contain,
      ),
    );
  }
}
