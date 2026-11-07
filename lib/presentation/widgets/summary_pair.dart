import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/transaction_summary.dart';
import 'summary_card.dart';

/// Side-by-side Total Income and Total Expenses cards.
class SummaryPair extends StatelessWidget {
  const SummaryPair({super.key, required this.summary});

  final TransactionSummary summary;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SummaryCard(
            label: AppStrings.totalIncome,
            amount: summary.totalIncome,
            income: true,
          ),
        ),
        const SizedBox(width: AppSpacing.s3),
        Expanded(
          child: SummaryCard(
            label: AppStrings.totalExpenses,
            amount: summary.totalExpense,
            income: false,
          ),
        ),
      ],
    );
  }
}
