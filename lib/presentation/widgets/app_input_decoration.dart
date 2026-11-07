import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

/// Rounded 1.5px outline in [color].
OutlineInputBorder buildInputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: AppRadius.mdAll,
    borderSide: BorderSide(color: color, width: 1.5),
  );
}

/// Shared look for text fields: filled surface, strong outline, primary focus and red
/// error.
InputDecoration buildInputDecoration(
  BuildContext context, {
  String? hint,
  Widget? prefix,
  Widget? suffix,
  double height = AppSpacing.controlHeight,
}) {
  final c = context.colors;

  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: c.inkMuted),
    filled: true,
    fillColor: c.surface,
    prefixIcon: prefix,
    prefixIconConstraints: const BoxConstraints(minWidth: 48),
    suffixIcon: suffix,
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: (height - 24) / 2),
    border: buildInputBorder(c.borderStrong),
    enabledBorder: buildInputBorder(c.borderStrong),
    focusedBorder: buildInputBorder(c.primary),
    errorBorder: buildInputBorder(c.expense),
    focusedErrorBorder: buildInputBorder(c.expense),
    errorStyle: TextStyle(color: c.expense, fontWeight: FontWeight.w600, fontSize: 12),
  );
}
