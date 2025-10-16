import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kiddos/main.dart';
import 'package:kiddos/pages/auth/authPage.dart';
import 'package:kiddos/pages/auth/login.dart';
import 'package:kiddos/pages/auth/otpPage.dart';
import 'package:kiddos/pages/auth/register.dart';
import 'package:kiddos/pages/child/childScaffold.dart';
import 'package:kiddos/pages/child/homeC/homeC.dart';
import 'package:kiddos/pages/child/rewardC/rewardC.dart';
import 'package:kiddos/pages/child/taskC/taskC.dart';
import 'package:kiddos/pages/parent/createTask/createTask.dart';
import 'package:kiddos/pages/parent/home/HomeP.dart';
import 'package:kiddos/pages/parent/me/me.dart';
import 'package:kiddos/pages/parent/me/settings/settings_page.dart';
import 'package:kiddos/pages/parent/parentScaffold.dart';
import 'package:kiddos/pages/parent/profile/profileP.dart';
import 'package:kiddos/pages/parent/progress/progressP.dart';
import 'package:kiddos/pages/parent/rewardPage/reward.dart';
import 'package:kiddos/pages/parent/task/TaskP.dart';

GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      builder: (BuildContext context, GoRouterState state) {
        return const AuthPage();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const Login();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const Register();
      },
    ),
    GoRoute(
      path: '/otp',
      builder: (BuildContext context, GoRouterState state) {
        return const OTPPage();
      },
    ),

    // routes for parent
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return ParentScaffold(child: child);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home-parent',
              builder: (context, state) => const HomeP(),
            ),
            GoRoute(
              path: '/create-task',
              builder: (context, state) => const CreateTask(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/task-parent',
              builder: (context, state) => const TaskP(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/progress-parent',
              builder: (context, state) => const ProgressP(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reward-parent',
              builder: (context, state) => const RewardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile-parent',
              builder: (context, state) => const ProfileP(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/me-parent',
              builder: (context, state) => const MeP(),
            ),
            GoRoute(
              path: '/settings-parent',
              builder: (context, state) => const SettingsP(),
            ),
          ],
        ),
      ],
    ),
    // routes for child
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) {
        return ChildScaffold(child: child);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home-child',
              builder: (context, state) => const HomeC(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/task-child',
              builder: (context, state) => const TaskC(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reward-child',
              builder: (context, state) => const RewardC(),
            ),
          ],
        ),
      ],
    ),
  ],
);
