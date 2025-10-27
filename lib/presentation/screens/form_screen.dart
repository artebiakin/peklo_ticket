import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/widgets.dart';

class FormScreen extends HookWidget {
  const FormScreen({super.key});

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
              const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => _Card(
                    onSelected: (value) {
                      debugPrint('Selected: $value');
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => _Card(
                    onSelected: (value) {
                      debugPrint('Selected: $value');
                    },
                  ),
                ),
              ),
              const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class _Slide3 extends HookWidget {
  final double width;
  final double height;

  const _Slide3({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    final counter = useState(1);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Введіть ім’я щасливчика',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  filled: true,
                  fillColor: Colors.red,
                  labelStyle: const TextStyle(fontSize: 46),
                ),
                minLines: 2,
                maxLines: null,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                ),
              ),
              const Text(
                'Скільки квитків?',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 97,
                child: Row(
                  spacing: 30,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => counter.value++,
                        child: Container(
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              '+',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            counter.value.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => counter.value--,
                        child: Container(
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () => context.go(AppRoute.chooseZone.path),
            child: Image.asset(image.buttonNext.path),
          ),
        ],
      ),
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
        width: 70,
        color: Colors.black,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentName.value,
              style: const TextStyle(color: Colors.white),
            )
                .animate(
                  key: ValueKey(currentName.value),
                  onComplete: (controller) {
                    currentName.value = names[random.nextInt(names.length - 1)];
                    controller.forward(from: 0);
                  },
                )
                .fadeIn(
                  duration: 500.ms,
                  curve: Curves.easeIn,
                )
                .then(delay: 1.seconds),
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
