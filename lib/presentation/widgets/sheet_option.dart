import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';

/// One selectable 48px row inside a bottom sheet.
class SheetOption extends StatelessWidget {
  const SheetOption({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final fg = selected ? c.primary : c.ink;

    return Material(
      color: selected ? c.primarySoft : c.transparent,
      borderRadius: AppRadius.mdAll,
      child: InkWell(
        borderRadius: AppRadius.mdAll,
        onTap: onTap,
        child: SizedBox(
          height: 48,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(icon, size: 20, color: fg),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: fg,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (selected) Icon(Icons.check_rounded, size: 20, color: c.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
