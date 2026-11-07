import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';

/// Standard surface card: border, 24px radius and the theme shadow.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.s4),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: c.border),
        boxShadow: c.cardShadow,
      ),
      child: child,
    );
  }
}
