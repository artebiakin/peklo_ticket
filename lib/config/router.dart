import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/presentation/screens/screens.dart';

enum AppRoute {
  dashboard,
  start,
  login,
  chooseZone,
  form,
  password;

  String get path {
    switch (this) {
      case AppRoute.dashboard:
        return '/dashboard';
      case AppRoute.start:
        return '/';
      case AppRoute.password:
        return '/password';
      case AppRoute.form:
        return '/form';
      case AppRoute.chooseZone:
        return '/chooseZone';
      case AppRoute.login:
        return '/login';
    }
  }
}

final router = GoRouter(
  initialLocation: AppRoute.start.path,
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
    GoRoute(
        path: AppRoute.login.path,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: AppRoute.form.path,
        builder: (context, state) => const FormScreen()),
    GoRoute(
        path: AppRoute.chooseZone.path,
        builder: (context, state) => const ChooseZoneScreen()),
  ],
);
