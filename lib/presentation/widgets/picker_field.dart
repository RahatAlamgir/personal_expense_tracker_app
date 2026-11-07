import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import 'field_label.dart';

/// Tappable field for values chosen from a sheet or dialog (category, date).
class PickerField<T> extends StatelessWidget {
  const PickerField({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.valueLabel,
    required this.placeholder,
    required this.onTap,
    this.validator,
  });

  final String label;
  final IconData icon;
  final T? value;
  final String? valueLabel;
  final String placeholder;
  final VoidCallback onTap;
  final FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return FormField<T>(
      key: ValueKey('$label-$value'),
      initialValue: value,
      validator: validator,
      builder: (state) {
        final hasError = state.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabel(label),
            Material(
              color: c.surface,
              borderRadius: AppRadius.mdAll,
              child: InkWell(
                borderRadius: AppRadius.mdAll,
                onTap: onTap,
                child: Container(
                  height: AppSpacing.controlHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.mdAll,
                    border: Border.all(
                      color: hasError ? c.expense : c.borderStrong,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(icon, size: 20, color: c.inkMuted),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          valueLabel ?? placeholder,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: valueLabel == null ? c.inkMuted : c.ink,
                              ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded, size: 22, color: c.inkMuted),
                    ],
                  ),
                ),
              ),
            ),
            if (hasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 14),
                child: Text(
                  state.errorText!,
                  style: TextStyle(
                    color: c.expense,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
