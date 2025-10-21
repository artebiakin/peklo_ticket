import 'package:flutter/material.dart';

import 'package:peklo_ticket/config/config.dart';

class CompleteWidget extends StatelessWidget {
  final VoidCallback onTap;
  final AnimationController controller;

  const CompleteWidget({
    super.key,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 23,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            'Ви увійшли',
            style: TextStyle(
              color: Colors.green,
              fontSize: 200,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 300,
              maxWidth: 300,
            ),
            child: Image.asset(image.loginDone.path),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) {
              if (value != 1) return const SizedBox.shrink();

              return GestureDetector(
                onTap: onTap,
                child: const Text(
                  'перейти до вибору місць',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              );
            }),
      ],
    );
  }
}
