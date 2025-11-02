import 'package:go_router/go_router.dart';

import 'package:peklo_ticket/config/router/blood_transition.dart';
import 'package:peklo_ticket/presentation/screens/complete_choose_zone_screen.dart';
import 'package:peklo_ticket/presentation/screens/extra_services_screen.dart';
import 'package:peklo_ticket/presentation/screens/finish_screen.dart';
import 'package:peklo_ticket/presentation/screens/screens.dart';

enum AppRoute {
  dashboard,
  start,
  login,
  chooseZone,
  completeChooseZone,
  extraServices,
  form,
  password,
  finish;

  String get path {
    switch (this) {
      case AppRoute.start:
        return '/';
      case AppRoute.dashboard:
        return '/dashboard';
      case AppRoute.password:
        return '/password';
      case AppRoute.form:
        return '/form';
      case AppRoute.chooseZone:
        return '/chooseZone';
      case AppRoute.completeChooseZone:
        return '/completeChooseZoneScreen';
      case AppRoute.extraServices:
        return '/extraServicesScreen';
      case AppRoute.login:
        return '/login';
      case AppRoute.finish:
        return '/finish';
    }
  }
}

final router = GoRouter(
  initialLocation: AppRoute.chooseZone.path,
  routes: [
    GoRoute(
      path: AppRoute.start.path,
      builder: (context, state) => const StartScreen(),
    ),
    GoRoute(
      path: AppRoute.password.path,
      pageBuilder: (context, state) => bloodTransitionPage(
        key: state.pageKey,
        child: const PasswordScreen(),
      ),
    ),
    GoRoute(
      path: AppRoute.dashboard.path,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
        path: AppRoute.login.path,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: AppRoute.form.path,
        builder: (context, state) => const FormScreen()),
    GoRoute(
      path: AppRoute.chooseZone.path,
      pageBuilder: (context, state) => bloodTransitionPage(
          key: state.pageKey, child: const ChooseZoneScreen()),
    ),
    GoRoute(
      path: AppRoute.completeChooseZone.path,
      pageBuilder: (context, state) => bloodTransitionPage(
          key: state.pageKey, child: const CompleteChooseZoneScreen()),
    ),
    GoRoute(
      path: AppRoute.extraServices.path,
      pageBuilder: (context, state) => bloodTransitionPage(
          key: state.pageKey, child: const ExtraServicesScreen()),
    ),
    GoRoute(
      path: AppRoute.finish.path,
      pageBuilder: (context, state) => bloodTransitionPage(
        key: state.pageKey,
        child: const FinishScreen(),
      ),
    ),
  ],
);
