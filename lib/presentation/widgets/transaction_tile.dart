import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/money_formatter.dart';
import '../../domain/entities/transaction_entity.dart';
import 'amount_text.dart';
import 'category_icons.dart';

/// Row for one transaction: category icon, title, "category / date" and signed amount.
/// Income and expense differ by colour, sign and label.
class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction, required this.onTap});

  final TransactionEntity transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;
    final isIncome = transaction.type.isIncome;
    final accent = isIncome ? c.income : c.expense;

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.mdAll,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 68),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Container(
                width: AppSpacing.tile,
                height: AppSpacing.tile,
                decoration: BoxDecoration(
                  color: isIncome ? c.incomeSoft : c.expenseSoft,
                  borderRadius: AppRadius.mdAll,
                ),
                child: Icon(transaction.category.icon, size: 22, color: accent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: t.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        height: 20 / 15,
                      ),
                    ),
                    Text(
                      AppStrings.categoryAndDate(
                        transaction.category.label,
                        DateFormatter.full(transaction.date),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: t.bodySmall!.copyWith(color: c.inkMuted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.42,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AmountText(
                      transaction.amount,
                      sign: isIncome ? AppStrings.plus : MoneyFormatter.minus,
                      style: t.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        height: 20 / 15,
                        color: accent,
                      ),
                    ),
                    Text(
                      transaction.type.label,
                      style: t.bodySmall!.copyWith(color: c.inkMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
