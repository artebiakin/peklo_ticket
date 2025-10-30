import 'dart:math';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/logo.dart';

class ExtraServicesScreen extends StatelessWidget {
  const ExtraServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Logo(),
      ),
      body: const HeadScrollFullscreen(),
    );
  }
}

class HeadScrollFullscreen extends StatefulWidget {
  const HeadScrollFullscreen({super.key});
  @override
  State<HeadScrollFullscreen> createState() => _HeadScrollFullscreenState();
}

class _HeadScrollFullscreenState extends State<HeadScrollFullscreen> {
  final scrollController = ScrollController();

  double _scrollY = 0;
  double bottomOverscroll = 0;
  double screenWidth = 0;

  static const double _sidePad = 0; // horizontal padding for head images

  final content = [
    'Забронювати квиток на концерт кобзона',
    'Забронювати квиток на концерт потапа (очікується)',
    'Побиття палицями краківської ковбаси',
    'тортури манною кашею з грудочками',
    'сауна з рідкого азоту',
    'пивні іньєкції (VIP послуга)',
    'ароматерапія шкарпетками тривалої витримки',
    'лекція на тему:\n“Філософія Сократа, Софокла та \n Арістотеля та її роль в глобальному потеплінні планети”',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        if (!mounted || scrollController.positions.isEmpty) return;

        final maxScroll = scrollController.position.maxScrollExtent;
        final currentScroll = scrollController.offset;

        setState(() {
          bottomOverscroll = currentScroll > maxScroll - screenWidth
              ? (-maxScroll + screenWidth + currentScroll)
                  .clamp(0, screenWidth / 2)
              : 0;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        screenWidth = constraints.maxWidth;
        // Starting at bottom (closed head)
        final double initialTop =
            constraints.maxHeight - screenWidth - screenWidth / 2;

        // Target: stick to very top of screen (fullscreen)
        const double targetTop = 0;

        final double slideUpDelta =
            (initialTop - targetTop).clamp(0, 99999).toDouble();
        final double slideNow = _scrollY.clamp(0, slideUpDelta);
        final double currentTop = initialTop - slideNow;

        return Stack(
          children: [
            // 📝 Scrollable content (center)
            NotificationListener<ScrollNotification>(
              onNotification: (n) {
                if (n is ScrollUpdateNotification) {
                  setState(() {
                    _scrollY = n.metrics.pixels;
                  });
                }
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                semanticChildCount: 0,
                padding: EdgeInsets.fromLTRB(
                  24,
                  screenHeight + 20,
                  24,
                  screenHeight + 20,
                ),
                itemCount: content.length,
                itemBuilder: (context, i) => Padding(
                  padding: EdgeInsets.only(bottom: screenHeight / 2),
                  child: ListItem(title: content[i]),
                ),
              ),
            ),

            Positioned(
              left: _sidePad,
              right: _sidePad,
              top: 0 - slideNow,
              child: const Text(
                'Хочеш підвищити рівень пекельного задоволення? Безсовісний!\n Обирай додаткові опції зі списку',
                style: TextStyle(
                  color: Color(0xFFF9A4DF),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            // 🔼 Top head – slides up with scroll, no rotation
            Positioned(
              left: _sidePad,
              right: _sidePad,
              top: currentTop,
              child: IgnorePointer(
                ignoring: true,
                child: AspectRatio(
                  aspectRatio: 1.25,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: screenWidth,
                      child: Image.asset(
                        image.headTop.path,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // 🔽 Bottom head – always fixed to the bottom
            Positioned(
              left: _sidePad,
              right: _sidePad,
              bottom: bottomOverscroll,
              child: IgnorePointer(
                ignoring: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: _sidePad),
                  child: SizedBox(
                    height: screenWidth,
                    child: Image.asset(
                      image.headBottom.path,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: _sidePad,
              right: _sidePad,
              bottom: bottomOverscroll +
                  (bottomOverscroll.clamp(0, 1) *
                      MediaQuery.paddingOf(context).bottom) -
                  screenWidth / 2,
              child: Container(
                decoration: const BoxDecoration(color: Color(0xFF27E030)),
                padding: const EdgeInsets.symmetric(horizontal: _sidePad),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.go(AppRoute.finish.path),
                      child: const Text(
                        'додати до пакєта',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    const Text(
                      '''до речі, 
вам великий чи маленький?
карта є?
Мобільний бажаєте поповнити?
купіть наклейку за 5 грн
А мілкіших грошей нема?''',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  static const colors = [
    Color(0xFFFFB253),
    Color(0xFF6CEBFF),
    Color(0xFFFF5C5C),
    Color(0xFFFFF36C),
    Color(0xFFB26CFF),
    Color(0xFF6CFF8E),
    Color(0xFFFF6FE2),
    Color(0xFF6C8CFF),
  ];

  final String title;

  const ListItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final randomInt = Random().nextInt(8);
    final textColor = colors[randomInt];

    return Row(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(
          width: 44,
          height: 44,
          child: Image.asset(image.rug.path),
        ),
        SizedBox(
          width: 44,
          height: 44,
          child: Image.asset(image.cart.path),
        ),
      ],
    );
  }
}
