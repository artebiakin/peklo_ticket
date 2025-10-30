import 'package:flutter/material.dart';
import 'package:peklo_ticket/presentation/widgets/marquee_text.dart';

class PriceWidget extends StatelessWidget {
  final bool reverse;

  const PriceWidget({super.key, this.reverse = false});

  @override
  Widget build(BuildContext context) {
    return MarqueeText(
      reverse: reverse,
      text:
          'Ціни: фан зона 1 - 35 000 дубових листочків, фан зона 2 - 28 000 кришечок кока коли, зона безалкогольних коктейлів - 18 000 іграшок хеппі міл, зона алкогольних коктейлів - 20 гривень.     ',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
