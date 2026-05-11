import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Vibors type scale.
///
/// Sizes follow a 1.25 ratio (modular scale). Latin uses Inter, Arabic
/// will fall back to system Arabic stack until we ship Vibors custom font.
class AppTypography {
  AppTypography._();

  // ─── Type Scale ──────────────────────────────────────────────
  // 12 → 14 → 16 → 18 → 22 → 28 → 36 → 56 → 72 → 120
  static const double caption = 12;
  static const double body = 14;
  static const double bodyLg = 16;
  static const double subtitle = 18;
  static const double title = 22;
  static const double h2 = 28;
  static const double h1 = 36;
  static const double display = 56;
  static const double displayLg = 72;
  static const double hero = 120;

  // ─── Weights ─────────────────────────────────────────────────
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight black = FontWeight.w900;

  // ─── Text Styles ─────────────────────────────────────────────
  static TextStyle get captionStyle => GoogleFonts.inter(
        fontSize: caption,
        fontWeight: regular,
        color: AppColors.textTertiary,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get bodyStyle => GoogleFonts.inter(
        fontSize: body,
        fontWeight: regular,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get bodyLgStyle => GoogleFonts.inter(
        fontSize: bodyLg,
        fontWeight: regular,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get subtitleStyle => GoogleFonts.inter(
        fontSize: subtitle,
        fontWeight: medium,
        color: AppColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get titleStyle => GoogleFonts.inter(
        fontSize: title,
        fontWeight: semibold,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get h2Style => GoogleFonts.inter(
        fontSize: h2,
        fontWeight: semibold,
        color: AppColors.textPrimary,
        height: 1.2,
        letterSpacing: -0.4,
      );

  static TextStyle get h1Style => GoogleFonts.inter(
        fontSize: h1,
        fontWeight: bold,
        color: AppColors.textPrimary,
        height: 1.15,
        letterSpacing: -0.6,
      );

  static TextStyle get displayStyle => GoogleFonts.inter(
        fontSize: display,
        fontWeight: bold,
        color: AppColors.textPrimary,
        height: 1.05,
        letterSpacing: -1.0,
      );

  /// Brand wordmark — uppercase, tight tracking, used for "VIBORS" lockup.
  static TextStyle get wordmarkStyle => GoogleFonts.inter(
        fontSize: display,
        fontWeight: black,
        color: AppColors.textPrimary,
        height: 1.0,
        letterSpacing: 4.0,
      );
}
