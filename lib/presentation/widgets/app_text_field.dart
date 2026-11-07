import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import 'app_input_decoration.dart';
import 'field_label.dart';

/// Labelled single-line text field with a leading icon.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.icon,
    this.validator,
    this.required = true,
    this.maxLength,
    this.textInputAction,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;
  final IconData? icon;
  final FormFieldValidator<String>? validator;
  final bool required;
  final int? maxLength;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label, required: required),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLength: maxLength,
          textInputAction: textInputAction,
          style: Theme.of(context).textTheme.bodyLarge,
          textCapitalization: TextCapitalization.sentences,
          decoration: buildInputDecoration(
            context,
            hint: hint,
            prefix: icon == null ? null : Icon(icon, size: 20, color: c.inkMuted),
          ).copyWith(counterText: ''),
        ),
      ],
    );
  }
}
