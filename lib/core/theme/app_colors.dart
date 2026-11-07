import 'package:flutter/material.dart';

/// Design-system colour tokens (see the Expense Tracker design system).
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.bg,
    required this.surface,
    required this.surfaceSunken,
    required this.border,
    required this.borderStrong,
    required this.ink,
    required this.inkMuted,
    required this.primary,
    required this.onPrimary,
    required this.primarySoft,
    required this.hero,
    required this.onHero,
    required this.heroOverlay,
    required this.secondary,
    required this.onSecondary,
    required this.income,
    required this.incomeSoft,
    required this.expense,
    required this.expenseSoft,
    required this.onExpense,
    required this.navBg,
    required this.fabBg,
    required this.onFab,
    required this.scrim,
    required this.transparent,
    required this.cardShadow,
  });

  final Color bg;
  final Color surface;
  final Color surfaceSunken;
  final Color border;
  final Color borderStrong;
  final Color ink;
  final Color inkMuted;
  final Color primary;
  final Color onPrimary;
  final Color primarySoft;
  final Color hero;
  final Color onHero;
  final Color heroOverlay;
  final Color secondary;
  final Color onSecondary;
  final Color income;
  final Color incomeSoft;
  final Color expense;
  final Color expenseSoft;
  final Color onExpense;
  final Color navBg;
  final Color fabBg;
  final Color onFab;
  final Color scrim;
  final Color transparent;
  final List<BoxShadow> cardShadow;

  static const light = AppColors(
    bg: Color(0xFFF4F6F3),
    surface: Color(0xFFFFFFFF),
    surfaceSunken: Color(0xFFE6EAE7),
    border: Color(0xFFDCE2DE),
    borderStrong: Color(0xFF7F8E88),
    ink: Color(0xFF14211D),
    inkMuted: Color(0xFF55655F),
    primary: Color(0xFF0F5F54),
    onPrimary: Color(0xFFFFFFFF),
    primarySoft: Color(0xFFD7EEE8),
    hero: Color(0xFF0F5F54),
    onHero: Color(0xFFFFFFFF),
    heroOverlay: Color(0x29FFFFFF),
    secondary: Color(0xFFF0B13B),
    onSecondary: Color(0xFF2B1E00),
    income: Color(0xFF0B7A4B),
    incomeSoft: Color(0xFFDDF3E7),
    expense: Color(0xFFB3360B),
    expenseSoft: Color(0xFFFBE6DD),
    onExpense: Color(0xFFFFFFFF),
    navBg: Color(0xFFE4E8E5),
    fabBg: Color(0xFF0F5F54),
    onFab: Color(0xFFFFFFFF),
    scrim: Color(0x8C0A1411),
    transparent: Color(0x00000000),
    cardShadow: [
      BoxShadow(color: Color(0x0F14211D), blurRadius: 2, offset: Offset(0, 1)),
      BoxShadow(color: Color(0x0D14211D), blurRadius: 16, offset: Offset(0, 6)),
    ],
  );

  static const dark = AppColors(
    bg: Color(0xFF0F1715),
    surface: Color(0xFF17221F),
    surfaceSunken: Color(0xFF1F2D29),
    border: Color(0xFF263632),
    borderStrong: Color(0xFF6F837C),
    ink: Color(0xFFEAF1EE),
    inkMuted: Color(0xFF9DB0A9),
    primary: Color(0xFF4FD1B5),
    onPrimary: Color(0xFF06241E),
    primarySoft: Color(0xFF12332D),
    hero: Color(0xFF1A5A4F),
    onHero: Color(0xFFF2FBF8),
    heroOverlay: Color(0x29FFFFFF),
    secondary: Color(0xFFF0B13B),
    onSecondary: Color(0xFF2B1E00),
    income: Color(0xFF4ADE9A),
    incomeSoft: Color(0xFF11362A),
    expense: Color(0xFFFF8A65),
    expenseSoft: Color(0xFF3D1F17),
    onExpense: Color(0xFF2A0F07),
    navBg: Color(0xFF1F2D29),
    fabBg: Color(0xFF4FD1B5),
    onFab: Color(0xFF06241E),
    scrim: Color(0xA6000000),
    transparent: Color(0x00000000),
    cardShadow: [],
  );

  @override
  AppColors copyWith() => this;

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return t < 0.5 ? this : other;
  }
}
