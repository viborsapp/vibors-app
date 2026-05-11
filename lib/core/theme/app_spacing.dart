/// 8pt spacing scale.
///
/// Every margin, padding, and gap in the app must use one of these values —
/// no arbitrary spacing. If you need a value not in this scale, propose
/// extending the scale, do not improvise inline.
class AppSpacing {
  AppSpacing._();

  /// 2px — micro-gaps inside dense components (badges, indicators).
  static const double xxs = 2;

  /// 4px — base unit, tight grouping (icon + text inline).
  static const double xs = 4;

  /// 8px — default gap between related elements.
  static const double sm = 8;

  /// 12px — section internal padding.
  static const double md = 12;

  /// 16px — default screen edge padding.
  static const double lg = 16;

  /// 24px — between distinct content groups.
  static const double xl = 24;

  /// 32px — between major sections.
  static const double xxl = 32;

  /// 48px — hero sections, large vertical rhythm.
  static const double xxxl = 48;

  /// 64px — full breakaway, e.g. between cover and content on splash.
  static const double mega = 64;
}

/// Corner radii — also on an 8pt-friendly scale.
class AppRadii {
  AppRadii._();

  static const double none = 0;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  /// Pill — fully rounded (use on chips, status pills).
  static const double pill = 999;
}
