import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import 'amount_text.dart';
import 'app_card.dart';

/// Half-width card showing Total Income or Total Expenses.
class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.label,
    required this.amount,
    required this.income,
  });

  final String label;
  final double amount;
  final bool income;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;
    final accent = income ? c.income : c.expense;

    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: income ? c.incomeSoft : c.expenseSoft,
                  borderRadius: AppRadius.mdAll,
                ),
                child: Icon(
                  income ? Icons.south_west_rounded : Icons.north_east_rounded,
                  size: 20,
                  color: accent,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  maxLines: 2,
                  style: t.bodyMedium!.copyWith(
                    color: c.inkMuted,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    height: 18 / 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AmountText(
            amount,
            compact: true,
            style: t.titleMedium!.copyWith(color: accent, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
