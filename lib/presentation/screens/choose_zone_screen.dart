import 'package:flutter/material.dart';

class ChooseZoneScreen extends StatelessWidget {
  const ChooseZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Choose Zone Screen',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
