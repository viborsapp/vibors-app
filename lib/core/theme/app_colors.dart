import 'package:flutter/material.dart';

/// Vibors brand color palette.
///
/// Source of truth: Vibors brand guidelines + V2.0 Figma tokens.
/// Do NOT introduce ad-hoc colors anywhere in the app — extend this file.
class AppColors {
  AppColors._();

  // ─── Brand Primary ─────────────────────────────────────────────
  /// Primary brand violet — used for primary CTAs, brand surfaces, V-mark.
  static const Color primary = Color(0xFF4E00FF);

  /// Lighter brand violet — used for hover, accents, secondary brand surfaces.
  static const Color accent = Color(0xFF9465FF);

  // ─── Brand Deep (background atmosphere) ────────────────────────
  /// Deep violet — primary background of the dark-violet glass aesthetic.
  static const Color deep = Color(0xFF08001F);

  /// Slightly lighter deep violet — used for elevated surfaces on deep bg.
  static const Color deepRaised = Color(0xFF11052D);

  // ─── Surface (glass layer) ─────────────────────────────────────
  /// Glass surface tint (low-opacity white over deep).
  static const Color glassWhite8 = Color(0x14FFFFFF); // 8% white
  static const Color glassWhite12 = Color(0x1FFFFFFF); // 12% white
  static const Color glassWhite16 = Color(0x29FFFFFF); // 16% white

  /// Border for glass surfaces (subtle hairline).
  static const Color glassBorder = Color(0x1FFFFFFF);

  // ─── Text ──────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF); // 70%
  static const Color textTertiary = Color(0x80FFFFFF); // 50%
  static const Color textDisabled = Color(0x4DFFFFFF); // 30%

  // ─── Status / Feedback ─────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // ─── Tier System (Vibors loyalty tiers) ────────────────────────
  static const Color tierBronze = Color(0xFFCD7F32);
  static const Color tierSilver = Color(0xFFC0C0C0);
  static const Color tierGold = Color(0xFFFFD700);
  static const Color tierPlatinum = Color(0xFFE5E4E2);

  // ─── Gradients ─────────────────────────────────────────────────
  /// Splash & hero background — radial deep violet.
  static const Gradient backgroundRadial = RadialGradient(
    center: Alignment.center,
    radius: 1.2,
    colors: [deepRaised, deep],
  );

  /// Primary CTA gradient — used on key action buttons.
  static const Gradient ctaPrimary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, accent],
  );

  /// Brand glow — used behind V-mark and key brand moments.
  static const Gradient brandGlow = RadialGradient(
    colors: [Color(0x664E00FF), Color(0x004E00FF)],
  );
}
