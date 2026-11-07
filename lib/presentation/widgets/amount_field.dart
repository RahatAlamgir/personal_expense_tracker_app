import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/money_formatter.dart';
import 'app_input_decoration.dart';
import 'field_label.dart';

/// Large amount field with a fixed ৳ prefix.
class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.controller,
    this.validator,
    this.textInputAction,
  });

  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final big = Theme.of(context).textTheme.displayMedium!.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w800,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(AppStrings.amountLabel),
        TextFormField(
          controller: controller,
          validator: validator,
          textInputAction: textInputAction,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,10}\.?\d{0,2}')),
          ],
          style: big,
          decoration: buildInputDecoration(
            context,
            hint: AppStrings.amountHint,
            height: 68,
            prefix: Padding(
              padding: const EdgeInsets.only(left: 14, right: 6),
              child: Text(
                MoneyFormatter.taka,
                style: AppTheme.takaStyle(big.copyWith(fontSize: 26, color: c.ink)),
              ),
            ),
          ).copyWith(
            hintStyle: big.copyWith(color: c.inkMuted),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
        ),
      ],
    );
  }
}
