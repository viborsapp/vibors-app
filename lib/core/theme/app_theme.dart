import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Vibors app-wide theme (dark-violet glass aesthetic).
///
/// Vibors is dark-first: we do not currently ship a light theme.
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.textPrimary,
      secondary: AppColors.accent,
      onSecondary: AppColors.textPrimary,
      surface: AppColors.deepRaised,
      onSurface: AppColors.textPrimary,
      error: AppColors.danger,
      onError: AppColors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.deep,
      canvasColor: AppColors.deep,

      // System UI overlay — translucent status & nav bars.
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),

      textTheme: TextTheme(
        displayLarge: AppTypography.displayStyle,
        displayMedium: AppTypography.h1Style,
        displaySmall: AppTypography.h2Style,
        headlineMedium: AppTypography.titleStyle,
        titleLarge: AppTypography.subtitleStyle,
        bodyLarge: AppTypography.bodyLgStyle,
        bodyMedium: AppTypography.bodyStyle,
        bodySmall: AppTypography.captionStyle,
      ),

      // Buttons (primary CTA baseline — components extend further).
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          textStyle: AppTypography.subtitleStyle.copyWith(
            fontWeight: AppTypography.semibold,
          ),
        ),
      ),

      // Outlined / ghost CTA.
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.glassBorder, width: 1),
          minimumSize: const Size.fromHeight(56),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
        ),
      ),

      // Text fields — glass surface, no harsh borders.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.glassWhite8,
        hintStyle: AppTypography.bodyLgStyle.copyWith(
          color: AppColors.textTertiary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.glassBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
      ),

      // Splash highlight (ripple) tuned to brand violet.
      splashColor: AppColors.primary.withValues(alpha: 0.12),
      highlightColor: AppColors.primary.withValues(alpha: 0.08),
    );
  }
}
