
import 'package:go_router/go_router.dart';

import 'package:smriti_setu/features/archive/domain/memory_message.dart';
import 'package:smriti_setu/features/archive/presentation/memory_archive_screen.dart';
import 'package:smriti_setu/features/archive/presentation/memory_detail_screen.dart';
import 'package:smriti_setu/features/auth/presentation/login_screen.dart';
import 'package:smriti_setu/features/auth/presentation/register_screen.dart';
import 'package:smriti_setu/features/onboarding/presentation/role_selection_screen.dart';
import 'package:smriti_setu/features/onboarding/presentation/splash_screen.dart';
import 'package:smriti_setu/features/sender/presentation/elderly_home_screen.dart';
import 'package:smriti_setu/features/sender/presentation/record_message_screen.dart';
import 'package:smriti_setu/features/sender/presentation/review_message_screen.dart';
import 'package:smriti_setu/features/sender/presentation/send_confirmation_screen.dart';
import 'package:smriti_setu/features/support/presentation/help_someone_screen.dart';
import 'package:smriti_setu/features/support/presentation/permissions_screen.dart';

// Centralized route definitions for Smriti Setu.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/role',
      name: 'role',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/help-someone',
      name: 'help-someone',
      builder: (context, state) => const HelpSomeoneScreen(),
    ),
    GoRoute(
      path: '/permissions',
      name: 'permissions',
      builder: (context, state) => const PermissionsScreen(),
    ),
    GoRoute(
      path: '/elderly-home',
      name: 'elderly-home',
      builder: (context, state) => const ElderlyHomeScreen(),
    ),
    GoRoute(
      path: '/record',
      name: 'record',
      builder: (context, state) => const RecordMessageScreen(),
    ),
    GoRoute(
      path: '/review',
      name: 'review',
      builder: (context, state) {
        final message = state.extra as String?;
        return ReviewMessageScreen(initialMessage: message);
      },
    ),
    GoRoute(
      path: '/confirmation',
      name: 'confirmation',
      builder: (context, state) {
        final message = state.extra as String?;
        return SendConfirmationScreen(sentMessage: message);
      },
    ),
    GoRoute(
      path: '/archive',
      name: 'archive',
      builder: (context, state) => const MemoryArchiveScreen(),
      routes: [
        GoRoute(
          path: 'detail',
          name: 'memory-detail',
          builder: (context, state) {
            final memory = state.extra as MemoryMessage?;
            final memoryId = state.uri.queryParameters['id'];
            return MemoryDetailScreen(
              memory: memory,
              memoryId: memoryId,
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
