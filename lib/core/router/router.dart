import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
// import '../guards/auth_guard.dart';
import '../guards/guest_guard.dart';

typedef Router = GoRouter;

late final Router router;

Future<void> setupRouter([String initialRoute = '/']) async {
  router = GoRouter(
    initialLocation: initialRoute,
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/login'),
      GoRoute(
        name: 'login',
        path: '/login',
        redirect: guestGuard,
        builder: (context, state) => const LoginPage(),
      ),
    ],
  );
}

extension RouterExtension on BuildContext {
  Future<void> navigateTo(String location) async {
    router.go(location);
  }
}
