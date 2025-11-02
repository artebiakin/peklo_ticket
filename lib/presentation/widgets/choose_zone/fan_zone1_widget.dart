import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';

class FanZone1Widget extends StatelessWidget {
  const FanZone1Widget({
    super.key,
  });

  void onTap(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Що на вас очікує в фан зоні 1:',
              textAlign: TextAlign.right,
            ),
            content: const Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                Text("Танці поки ваш скелет не розсиплеться"),
                Text("Обливання гарячою лавою"),
                Text("ТокПінна вечірка зі сльозогінним газом"),
                Text(
                    "Конкурс “Виколи собі очі або подивись серіал “Школа” (всі серії)"),
                Text("Веселий конкурс “Відгадай чий це череп”"),
                Text("Букмекерські ставки “Хто наступний в пекло” "),
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
        image.fanZone1.path,
        fit: BoxFit.contain,
      ),
    );
  }
}
