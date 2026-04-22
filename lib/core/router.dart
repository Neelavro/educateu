import 'package:educateu/presentation/onboarding/screens/account_activate_screen.dart';
import 'package:educateu/presentation/onboarding/screens/forgot_password_screen.dart';
import 'package:educateu/presentation/onboarding/screens/login_screen.dart';
import 'package:educateu/presentation/onboarding/screens/otp_screen.dart';
import 'package:educateu/presentation/profile/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../presentation/main_shell/main_shell_screen.dart';
import '../providers/authentication_provider.dart';

final appRouter = GoRouter(
  initialLocation: '/profile',
  routes: [

    // ── Auth routes ───────────────────────────────────────────
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/account-activate',
      builder: (context, state) => ChangeNotifierProvider.value(
        value: state.extra as AuthenticationProvider,
        child: const AccountActivateScreen(),
      ),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ChangeNotifierProvider.value(
          value: extra['provider'] as AuthenticationProvider,
          child: OtpScreen(email: extra['email'] as String),
        );
      },
    ),

    // ── Main app shell ────────────────────────────────────────
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainShell(navigationShell: shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/explore',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Explore'))),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/courses',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Courses'))),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/exams',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Exams'))),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/inbox',
            builder: (context, state) => const Scaffold(body: Center(child: Text('Inbox'))),
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ]),
      ],
    ),
  ],
);