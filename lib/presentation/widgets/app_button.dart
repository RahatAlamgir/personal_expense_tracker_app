import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import 'app_button_variant.dart';

/// Full-width 52px button in one of the [AppButtonVariant] styles.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (Color bg, Color fg, Color? border) = switch (variant) {
      AppButtonVariant.primary => (c.primary, c.onPrimary, null),
      AppButtonVariant.secondary => (c.surface, c.ink, c.borderStrong),
      AppButtonVariant.danger => (c.expense, c.onExpense, null),
      AppButtonVariant.dangerOutline => (c.transparent, c.expense, c.expense),
      AppButtonVariant.ghost => (c.transparent, c.primary, null),
    };
    final style = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(0, AppSpacing.controlHeight)),
      padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
      elevation: const WidgetStatePropertyAll(0),
      backgroundColor: WidgetStatePropertyAll(bg),
      foregroundColor: WidgetStatePropertyAll(fg),
      overlayColor: WidgetStatePropertyAll(fg.withValues(alpha: 0.08)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: border == null ? BorderSide.none : BorderSide(color: border, width: 1.5),
        ),
      ),
      textStyle: WidgetStatePropertyAll(
        Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
      ),
    );
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
        Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
    final button = TextButton(onPressed: onPressed, style: style, child: child);

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
