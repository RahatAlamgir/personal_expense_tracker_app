import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/transaction_type.dart';
import 'category_icons.dart';
import 'sheet_option.dart';

/// Bottom sheet that lists categories. [onSelected] receives null for "All categories".
Future<void> showCategorySheet(
  BuildContext context, {
  TransactionType? type,
  Category? selected,
  bool includeAll = false,
  required ValueChanged<Category?> onSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.7),
    builder: (sheetContext) {
      void pick(Category? category) {
        Navigator.pop(sheetContext);
        onSelected(category);
      }

      final sections = type == null
          ? [TransactionType.expense, TransactionType.income]
          : [type];

      return SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(AppSpacing.s4, 0, AppSpacing.s4, AppSpacing.s4),
          children: [
            if (includeAll)
              SheetOption(
                icon: Icons.apps_rounded,
                label: AppStrings.allCategories,
                selected: selected == null,
                onTap: () => pick(null),
              ),
            for (final section in sections) ...[
              if (type == null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 12, 10, 4),
                  child: Text(
                    section.label.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: context.colors.inkMuted,
                        ),
                  ),
                ),
              for (final category in Category.forType(section))
                SheetOption(
                  icon: category.icon,
                  label: category.label,
                  selected: selected == category,
                  onTap: () => pick(category),
                ),
            ],
          ],
        ),
      );
    },
  );
}
