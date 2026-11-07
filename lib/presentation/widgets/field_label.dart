import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';

/// Form label that appends a red `*` (required) or `(optional)`.
class FieldLabel extends StatelessWidget {
  const FieldLabel(this.text, {super.key, this.required = true});

  final String text;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          height: 18 / 13,
        );

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text.rich(
        TextSpan(
          text: text,
          children: [
            if (required)
              TextSpan(
                text: AppStrings.requiredSuffix,
                style: TextStyle(color: c.expense, fontWeight: FontWeight.w800),
              )
            else
              TextSpan(
                text: AppStrings.optionalSuffix,
                style: TextStyle(color: c.inkMuted, fontWeight: FontWeight.w500),
              ),
          ],
        ),
        style: style,
      ),
    );
  }
}
