import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_spacing.dart';
import 'app_button.dart';
import 'app_button_variant.dart';
import 'app_card.dart';

/// Icon, title, message and optional action shown where a list would be.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.actionIcon,
    this.actionVariant = AppButtonVariant.primary,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final IconData? actionIcon;
  final AppButtonVariant actionVariant;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;

    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s8, horizontal: AppSpacing.s4),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(color: c.primarySoft, shape: BoxShape.circle),
            child: Icon(icon, size: 32, color: c.primary),
          ),
          const SizedBox(height: 16),
          Text(title, style: t.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: t.bodyMedium!.copyWith(color: c.inkMuted),
            ),
          ),
          if (actionLabel != null) ...[
            const SizedBox(height: 20),
            AppButton(
              label: actionLabel!,
              icon: actionIcon,
              variant: actionVariant,
              expand: false,
              onPressed: onAction,
            ),
          ],
        ],
      ),
    );
  }
}
