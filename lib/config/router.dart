import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/presentation/screens/screens.dart';

enum AppRoute {
  dashboard,
  start,
  password;

  String get path {
    switch (this) {
      case AppRoute.dashboard:
        return '/dashboard';
      case AppRoute.start:
        return '/';
      case AppRoute.password:
        return '/password';
    }
  }
}

final router = GoRouter(
  initialLocation: AppRoute.dashboard.path,
  routes: [
    GoRoute(
        path: AppRoute.start.path,
        builder: (context, state) => const StartScreen()),
    GoRoute(
        path: AppRoute.password.path,
        builder: (context, state) => const PasswordScreen()),
    GoRoute(
        path: AppRoute.dashboard.path,
        builder: (context, state) => const DashboardScreen()),
  ],
);
