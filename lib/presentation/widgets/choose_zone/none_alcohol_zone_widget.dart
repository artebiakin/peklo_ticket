import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';

class NoneAlcoholZoneWidget extends StatefulWidget {
  const NoneAlcoholZoneWidget({super.key});

  @override
  State<NoneAlcoholZoneWidget> createState() => _NoneAlcoholZoneWidgetState();
}

class _NoneAlcoholZoneWidgetState extends State<NoneAlcoholZoneWidget> {
  void onTap() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Що на вас очікує в зоні безалкогольних коктейлів:',
              textAlign: TextAlign.right,
            ),
            content: const Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                Text("Безкоштовні безалкогольні коктейлі:"),
                Text("“ЛимонАД картопляний”"),
                Text("“Узвар з сушених щурів та самки богомола”"),
                Text("“Компот Поживний зі смальцем”"),
                Text(
                    "“Швидкий молочний коктейль з оселедцем та солоними огірками”"),
                Text("“Оранж кава” з ноткою нашатирного спирту."),
                Text("“Ковід” без смаку, без запаху."),
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
      onTap: onTap,
      child: Image.asset(
        image.nonAlcoholicCoctailsZone.path,
        fit: BoxFit.contain,
      ),
    );
  }
}
