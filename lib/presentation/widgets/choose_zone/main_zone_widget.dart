import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';

class MainZoneWidget extends StatefulWidget {
  const MainZoneWidget({super.key});

  @override
  State<MainZoneWidget> createState() => _MainZoneWidgetState();
}

class _MainZoneWidgetState extends State<MainZoneWidget> {
  void onTap() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Що на вас очікує на головній сцені:',
              textAlign: TextAlign.right,
            ),
            content: const Wrap(
              spacing: 32,
              runSpacing: 32,
              children: [
                Text(
                    "Сміхопанорама з петросяном, регіной дубовіцкой, юрієм гальцевим"),
                Text("Прослуховування пісні Петра Щура “Мамині світлиці” 24/7"),
                Text(
                    "Анімашки під “Жу жу жу маленька бджілка” та “Черепаха аха аха”"),
                Text("Онлайн трансляція гри што гдє кагда з борисом бурдою"),
                Text("Караоке з Андрієм Мацевко"),
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
        image.mainStage.path,
        fit: BoxFit.cover,
      ),
    );
  }
}
