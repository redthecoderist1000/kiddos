import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/main.dart';
import 'package:kiddos/pages/auth/authPage.dart';

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),
  ],
);
