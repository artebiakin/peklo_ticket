import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/choose_zone/alcohol_zone_widget.dart';
import 'package:peklo_ticket/presentation/widgets/choose_zone/fan_zone1_widget.dart';
import 'package:peklo_ticket/presentation/widgets/choose_zone/fan_zone2_widget.dart';
import 'package:peklo_ticket/presentation/widgets/choose_zone/main_zone_widget.dart';
import 'package:peklo_ticket/presentation/widgets/choose_zone/none_alcohol_zone_widget.dart';
import 'package:peklo_ticket/presentation/widgets/choose_zone/price_widget.dart';

class ChooseZoneScreen extends HookWidget {
  const ChooseZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InteractiveViewer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const PriceWidget(),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(image.chooseZoneBg.path),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: const Column(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: MainZoneWidget()),
                        Expanded(
                          child: Row(
                            spacing: 16,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: AlcoholZoneWidget()),
                              Expanded(child: FanZone1Widget()),
                              Expanded(child: NoneAlcoholZoneWidget()),
                            ],
                          ),
                        ),
                        Expanded(child: FanZone2Widget()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const PriceWidget(reverse: true),
          ],
        ),
      ),
    );
  }
}
