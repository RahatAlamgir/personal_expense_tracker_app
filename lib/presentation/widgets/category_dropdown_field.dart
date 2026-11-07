import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/transaction_type.dart';
import 'app_input_decoration.dart';
import 'category_icons.dart';
import 'field_label.dart';

/// Category picker built on DropdownButtonFormField; lists categories for [type].
class CategoryDropdownField extends StatelessWidget {
  const CategoryDropdownField({
    super.key,
    required this.type,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  final TransactionType type;
  final Category? value;
  final ValueChanged<Category?> onChanged;
  final FormFieldValidator<Category>? validator;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(AppStrings.categoryLabel),
        DropdownButtonFormField<Category>(
          key: ValueKey(type),
          initialValue: value,
          isExpanded: true,
          validator: validator,
          onChanged: onChanged,
          borderRadius: AppRadius.lgAll,
          dropdownColor: c.surface,
          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 22, color: c.inkMuted),
          style: Theme.of(context).textTheme.bodyLarge,
          hint: Text(
            AppStrings.categoryPlaceholder,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: c.inkMuted),
          ),
          decoration: buildInputDecoration(
            context,
            prefix: Icon(Icons.sell_outlined, size: 20, color: c.inkMuted),
          ),
          items: [
            for (final category in Category.forType(type))
              DropdownMenuItem(
                value: category,
                child: Row(
                  children: [
                    Icon(category.icon, size: 20, color: c.ink),
                    const SizedBox(width: 12),
                    Expanded(child: Text(category.label, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
