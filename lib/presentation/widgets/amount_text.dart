import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/money_formatter.dart';

/// Taka amount with an optional sign. The ৳ glyph is set in a font that has it.
class AmountText extends StatelessWidget {
  const AmountText(
    this.amount, {
    super.key,
    required this.style,
    this.sign = '',
    this.compact = false,
    this.maxLines = 1,
    this.textAlign,
  });

  final double amount;
  final TextStyle style;
  final String sign;
  final bool compact;
  final int maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final base = style.copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
    final number = compact ? MoneyFormatter.compact(amount) : MoneyFormatter.format(amount);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: sign),
          TextSpan(text: MoneyFormatter.taka, style: AppTheme.takaStyle(base)),
          TextSpan(text: '${AppStrings.thinSpace}$number'),
        ],
      ),
      style: base,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
