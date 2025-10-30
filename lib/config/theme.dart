import 'package:flutter/material.dart';

final theme = ThemeData(
  canvasColor: Colors.black,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    shadowColor: Colors.transparent,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: Color(0XFFFBFF00),
    titleTextStyle: TextStyle(
      color: Color(0xFFFFB253),
      fontSize: 16,
      fontWeight: FontWeight.w800,
    ),
    contentTextStyle: TextStyle(
      fontSize: 16,
      color: Color(0xFFFFB253),
    ),
  ),
);
