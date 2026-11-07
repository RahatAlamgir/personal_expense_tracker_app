import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/money_formatter.dart';
import '../../domain/entities/transaction_entity.dart';
import 'amount_text.dart';

/// Date-group heading with the day's net total.
class DayHeader extends StatelessWidget {
  const DayHeader({super.key, required this.day, required this.items, required this.now});

  final DateTime day;
  final List<TransactionEntity> items;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final style = Theme.of(context).textTheme.labelSmall!.copyWith(color: c.inkMuted);
    var net = 0.0;
    for (final t in items) {
      net += t.type.isIncome ? t.amount : -t.amount;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(DateFormatter.groupHeader(day, now).toUpperCase(), style: style),
          ),
          AmountText(
            net.abs(),
            sign: net < 0 ? MoneyFormatter.minus : AppStrings.plus,
            style: style,
          ),
        ],
      ),
    );
  }
}
