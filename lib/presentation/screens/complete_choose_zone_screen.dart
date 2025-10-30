import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';

class CompleteChooseZoneScreen extends StatelessWidget {
  const CompleteChooseZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.close, color: Colors.red),
            label: const Text('закрити не можна,\nзабагато хочеш'),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              image.completeChoozeBg.path,
              fit: BoxFit.contain,
            ),
          ),
          RichText(
            text: const TextSpan(
              text: 'дякуємо за ',
              style: TextStyle(
                color: Color(0xFFFFA2A2),
                fontSize: 40,
              ),
              children: [
                TextSpan(
                  text: 'вибір ',
                  style: TextStyle(
                    color: Color(0xFFFFB253),
                    fontWeight: FontWeight.w600,
                    fontSize: 64,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: 'канєшно...',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                    fontSize: 86,
                  ),
                ),
                TextSpan(text: '\n'),
                TextSpan(
                  text: 'але не від всього серця',
                  style: TextStyle(
                    color: Color(0xFFFBFF00),
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 10,
            child: SafeArea(
              child: GestureDetector(
              onTap: () => context.go(AppRoute.extraServices.path),
                child: Container(
                  height: 104,
                  decoration: BoxDecoration(
                    color: const Color(0xFF27E030),
                    borderRadius: BorderRadius.circular(300),
                  ),
                  child: const Text(
                    'обрати додаткові пекельні насолоди',
                    style: TextStyle(
                      color: Color(0xFFFFB253),
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
