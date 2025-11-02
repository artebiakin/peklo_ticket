import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:peklo_ticket/app.dart';
import 'package:peklo_ticket/config/config.dart';
import 'package:peklo_ticket/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;

  await AudioplayersService().init(
    preloadSfxAssets: [audio.aMp3_____],
  );

  runApp(const App());
}
