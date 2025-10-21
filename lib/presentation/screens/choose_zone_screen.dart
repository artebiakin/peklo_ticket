import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/widgets.dart';

class ChooseZoneScreen extends HookWidget {
  const ChooseZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewTransformationController = useTransformationController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => InteractiveViewer(
          transformationController: viewTransformationController,
          constrained: false,
          minScale: 0.1,
          maxScale: 2.0,
          alignment: Alignment.center,
          child: Row(
            children: [
              _Slide1(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
              _Slide2(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
              _Slide3(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slide1 extends StatelessWidget {
  final double width;
  final double height;

  const _Slide1({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.7,
      height: height,
      child: Column(
        children: [
          const SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 20),
            child: Logo(),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Для кого обираєш квиток?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 25,
            children: [
              Image.asset(image.cart.path),
              Image.asset(image.rug.path),
            ],
          ),
        ],
      ),
    );
  }
}

class _Slide2 extends StatelessWidget {
  final double width;
  final double height;

  const _Slide2({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            image.formBg.path,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox.shrink(),
              _Card(
                onSelected: (value) {
                  debugPrint('Selected: $value');
                },
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: List.generate(
              //     4,
              //     (index) => _Card(
              //       onSelected: (value) {
              //         debugPrint('Selected: $value');
              //       },
              //     ),
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: List.generate(
              //     4,
              //     (index) => _Card(
              //       onSelected: (value) {
              //         debugPrint('Selected: $value');
              //       },
              //     ),
              //   ),
              // ),
              const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class _Slide3 extends StatelessWidget {
  final double width;
  final double height;

  const _Slide3({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Text('Slide 3'),
    );
  }
}

class _Card extends HookWidget {
  final ValueChanged<String>? onSelected;

  const _Card({this.onSelected});

  @override
  Widget build(BuildContext context) {
    final random = useMemoized(() => Random());
    final avatars = useMemoized(() => [
          image.avatar1.path,
          image.avatar2.path,
          image.avatar3.path,
          image.avatar4.path,
          image.avatar5.path,
          image.avatar6.path,
          image.avatar7.path,
          image.avatar8.path,
        ]);
    final names = useMemoized(() => [
          'для себе',
          'для друга',
          'для проджекта',
          'для тімліда',
          'для ментора',
        ]);

    final currentName = useState(names[random.nextInt(names.length - 1)]);
    final currentAvatar = useState(
      avatars[random.nextInt(avatars.length - 1)],
    );

    return GestureDetector(
      onTap: () => onSelected?.call(currentName.value),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(currentName.value)
                .animate(
                  key: ValueKey(currentName.value),
                )
                .fadeIn(duration: 350.ms),
            Image.asset(currentAvatar.value)
                .animate(
                  key: ValueKey(currentAvatar.value),
                  onComplete: (controller) {
                    currentAvatar.value =
                        avatars[random.nextInt(avatars.length - 1)];
                    controller.forward(from: 0);
                  },
                )
                .fadeIn(
                  duration: 500.ms,
                  curve: Curves.easeIn,
                )
                .then(delay: 1.seconds),
          ],
        ),
      ),
    );
  }
}
