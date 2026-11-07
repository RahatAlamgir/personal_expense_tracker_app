import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_radius.dart';

/// Builds the light and dark [ThemeData] from [AppColors] and the design-system type scale.
abstract final class AppTheme {
  static ThemeData get light => _build(AppColors.light, Brightness.light);
  static ThemeData get dark => _build(AppColors.dark, Brightness.dark);

  /// Font that supplies the ৳ glyph, which Plus Jakarta Sans lacks.
  static TextStyle takaStyle(TextStyle base) {
    return GoogleFonts.notoSansBengali(
      textStyle: base,
      fontWeight: base.fontWeight,
    );
  }

  static TextStyle _t(double size, double line, FontWeight w, {double ls = 0}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      height: line / size,
      fontWeight: w,
      letterSpacing: ls,
    );
  }

  static TextTheme _textTheme(AppColors c) {
    return TextTheme(
      displayLarge: _t(34, 40, FontWeight.w800, ls: -0.5),
      displayMedium: _t(28, 34, FontWeight.w800, ls: -0.3),
      titleLarge: _t(22, 28, FontWeight.w800),
      titleMedium: _t(18, 24, FontWeight.w700),
      titleSmall: _t(16, 22, FontWeight.w700),
      bodyLarge: _t(16, 24, FontWeight.w500),
      bodyMedium: _t(14, 20, FontWeight.w500),
      bodySmall: _t(12, 16, FontWeight.w500),
      labelLarge: _t(15, 20, FontWeight.w700),
      labelSmall: _t(12, 16, FontWeight.w700, ls: 0.4),
    ).apply(bodyColor: c.ink, displayColor: c.ink);
  }

  static ThemeData _build(AppColors c, Brightness brightness) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: c.primary,
      onPrimary: c.onPrimary,
      secondary: c.secondary,
      onSecondary: c.onSecondary,
      error: c.expense,
      onError: c.onExpense,
      surface: c.surface,
      onSurface: c.ink,
      outline: c.borderStrong,
      outlineVariant: c.border,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: c.bg,
      canvasColor: c.bg,
      textTheme: _textTheme(c),
      extensions: [c],
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: c.bg,
        foregroundColor: c.ink,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: c.ink,
        contentTextStyle: _t(14, 20, FontWeight.w700).copyWith(color: c.bg),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdAll),
        insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 112),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.fabBg,
        foregroundColor: c.onFab,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        iconSize: 28,
        sizeConstraints: const BoxConstraints.tightFor(width: 60, height: 60),
        shape: CircleBorder(side: BorderSide(color: c.bg, width: 4)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        modalBarrierColor: c.scrim,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xlAll),
        headerBackgroundColor: c.hero,
        headerForegroundColor: c.onHero,
        todayForegroundColor: WidgetStatePropertyAll(c.primary),
        todayBorder: BorderSide(color: c.primary, width: 1.5),
        dayStyle: _t(14, 20, FontWeight.w600),
      ),
      dividerTheme: DividerThemeData(color: c.border, space: 1, thickness: 1),
      textSelectionTheme: TextSelectionThemeData(cursorColor: c.primary),
    );
  }
}
