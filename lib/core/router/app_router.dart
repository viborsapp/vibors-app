import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/presentation/splash_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// App route table.
///
/// Routes are added feature by feature. For now we have splash + a
/// placeholder for auth (replaced once the auth feature is built).
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => const _ComingSoonScreen(
          title: 'Authentication',
          subtitle: 'Sign-Up & Sign-In flows are designed and ready.\nWiring up next.',
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const _ComingSoonScreen(
          title: 'Home Feed',
          subtitle: 'The main social feed lands here.',
        ),
      ),
    ],
  );
}

/// Generic placeholder for unbuilt features — keeps the router valid
/// while we ship feature by feature.
class _ComingSoonScreen extends StatelessWidget {
  const _ComingSoonScreen({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundRadial,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: AppTypography.h1Style, textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  subtitle,
                  style: AppTypography.bodyLgStyle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxxl),
                FilledButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Replay splash'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
