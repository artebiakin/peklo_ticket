import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OverlayWidget extends HookWidget {
  final VoidCallback? onTap;
  const OverlayWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    final flexSize = useState(1);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0xff27e030),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'ОЛЄГ, \nТИ ШО \nПЛАЧЕШ?',
              style: TextStyle(
                color: Color(0xFFFFA2A2),
                fontSize: 128,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => flexSize.value++,
                  child: const FittedBox(
                    child: Text(
                      'ПЛАЧУ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: flexSize.value,
                child: GestureDetector(
                  onTap: onTap,
                  child: const FittedBox(
                    child: Text(
                      'НЄ,\nЯ СМІЮСЯ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
