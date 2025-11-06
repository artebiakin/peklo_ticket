import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/presentation/widgets/widgets.dart';
import 'package:peklo_ticket/utils/lowercase_text_input_formatter.dart';

class FormScreen extends HookWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewTransformationController = useTransformationController();

    final selectedNames = useState<List<String>>([]);

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
                onSelected: (names) => selectedNames.value = names,
              ),
              _Slide3(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                selectedNames: selectedNames.value,
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

class _Slide2 extends HookWidget {
  final double width;
  final double height;

  final ValueChanged<List<String>>? onSelected;

  const _Slide2({required this.width, required this.height, this.onSelected});

  @override
  Widget build(BuildContext context) {
    final selectedNames = useState<List<String>>([]);

    void handleSelection(String name) {
      if (name.isEmpty) {
        selectedNames.value =
            selectedNames.value.where((element) => element != name).toList();
      } else {
        selectedNames.value = [...selectedNames.value, name];
      }
      onSelected?.call(selectedNames.value);
    }

    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Stack(
          children: [
            Image.asset(
              image.formBg.path,
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    flex: 3,
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => _Card(onSelected: handleSelection),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        4,
                        (index) => _Card(onSelected: handleSelection),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Slide3 extends HookWidget {
  final double width;
  final double height;

  final List<String> selectedNames;

  const _Slide3({
    required this.width,
    required this.height,
    required this.selectedNames,
  });

  @override
  Widget build(BuildContext context) {
    final counter = useState(0);
    final name = useState('');

    final dataValid =
        selectedNames.isNotEmpty && name.value.isNotEmpty && counter.value > 0;
    final onNext =
        dataValid ? () => context.go(AppRoute.chooseZone.path) : null;

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
                inputFormatters: [
                  LowercaseTextInputFormatter(),
                ],
                onChanged: (value) => name.value = value,
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
                        onTap: () => counter.value += Random().nextInt(3) + 1,
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
                        onTap: () => counter.value -= Random().nextInt(2) + 1,
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
            onTap: onNext,
            child: Opacity(
              opacity: onNext != null ? 1 : 0.2,
              child: Image.asset(image.buttonNext.path),
            ),
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

    final isSelected = useState(false);
    final selectedName = useState<String?>(null);
    final selectedAvatar = useState<String?>(null);

    return GestureDetector(
      onTap: () {
        isSelected.value = !isSelected.value;
        if (isSelected.value) {
          selectedName.value = currentName.value;
          selectedAvatar.value = currentAvatar.value;
          onSelected?.call(currentName.value);
        } else {
          selectedName.value = null;
          selectedAvatar.value = null;
          onSelected?.call('');
        }
      },
      child: Column(
        spacing: 12,
        children: [
          Image.asset(
            isSelected.value ? image.addButtonRed.path : image.addButton.path,
          ),
          Expanded(
            child: Container(
              width: 70,
              height: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.yellow, width: 4),
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  if (selectedName.value != null)
                    Text(
                      selectedName.value!,
                      style: const TextStyle(color: Colors.white),
                    )
                        .animate(
                          key: ValueKey(selectedName.value),
                        )
                        .fadeIn(
                          duration: 500.ms,
                          curve: Curves.easeIn,
                        )
                  else
                    Text(
                      currentName.value,
                      style: const TextStyle(color: Colors.white),
                    )
                        .animate(
                          key: ValueKey(currentName.value),
                          onComplete: (controller) {
                            currentName.value =
                                names[random.nextInt(names.length - 1)];
                            controller.forward(from: 0);
                          },
                        )
                        .fadeIn(
                          duration: 500.ms,
                          curve: Curves.easeIn,
                        )
                        .then(delay: 1.seconds),
                  if (selectedAvatar.value != null)
                    Image.asset(
                      selectedAvatar.value!,
                    )
                        .animate(
                          key: ValueKey(selectedAvatar.value),
                        )
                        .fadeIn(
                          duration: 500.ms,
                          curve: Curves.easeIn,
                        )
                  else
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
          ),
        ],
      ),
    );
  }
}
