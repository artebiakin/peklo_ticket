import 'package:flutter/material.dart';

class LoginError extends StatelessWidget {
  final VoidCallback? onAcknowledged;

  const LoginError({
    super.key,
    this.onAcknowledged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Expanded(
            child: Text(
              'Вийди і зайди нормально!',
              maxLines: 5,
              style: TextStyle(
                color: Colors.red,
                fontSize: 80,
              ),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: onAcknowledged,
                child: const Text(
                  'поняв',
                  style: TextStyle(color: Colors.green, fontSize: 24),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
