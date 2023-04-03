import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/app/presentation/pages/ambient_page.dart';
import '../../features/app/presentation/pages/ambients_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../guards/auth_guard.dart';
import '../guards/guest_guard.dart';

typedef Router = GoRouter;

late final Router router;

Future<void> setupRouter([String initialRoute = '/']) async {
  router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(
        name: 'login',
        path: '/login',
        redirect: guestGuard,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: 'ambients',
        path: '/',
        redirect: authGuard,
        builder: (context, state) => const AmbientsPage(),
      ),
      GoRoute(
        name: 'ambient',
        path: '/ambient/:ambientId',
        redirect: authGuard,
        builder: (context, state) => AmbientPage(state.params['ambientId']!),
      ),
    ],
  );
}

extension RouterExtension on BuildContext {
  Future<void> navigateTo(String location, {bool replace = true}) async {
    if (replace) {
      router.go(location);
    } else {
      router.push(location);
    }
  }

  Future<void> navigateBack() async {
    if (router.canPop()) {
      router.pop();
    }
  }
}
