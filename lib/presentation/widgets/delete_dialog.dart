import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/money_formatter.dart';
import '../../domain/entities/transaction_entity.dart';
import 'app_button.dart';
import 'app_button_variant.dart';

/// Confirmation AlertDialog shown before a transaction is deleted.
class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.transaction});

  final TransactionEntity transaction;

  /// Resolves to true when the user confirms deletion.
  static Future<bool> confirm(BuildContext context, TransactionEntity transaction) async {
    final result = await showDialog<bool>(
      context: context,
      barrierColor: context.colors.scrim,
      builder: (_) => DeleteDialog(transaction: transaction),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;
    final sign = transaction.type.isIncome ? AppStrings.plus : MoneyFormatter.minus;

    return AlertDialog(
      insetPadding: const EdgeInsets.all(24),
      contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      actionsPadding: const EdgeInsets.all(24),
      icon: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(color: c.expenseSoft, shape: BoxShape.circle),
        child: Icon(Icons.delete_outline_rounded, size: 26, color: c.expense),
      ),
      title: Text(AppStrings.deleteTitle, style: t.titleMedium, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.deleteMessage,
            textAlign: TextAlign.center,
            style: t.bodyMedium!.copyWith(color: c.inkMuted),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: c.surfaceSunken, borderRadius: AppRadius.mdAll),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: t.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  AppStrings.amountWithMeta(
                    sign,
                    MoneyFormatter.format(transaction.amount),
                    DateFormatter.full(transaction.date),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: t.bodySmall!.copyWith(color: c.inkMuted),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: AppStrings.cancel,
                variant: AppButtonVariant.secondary,
                onPressed: () => Navigator.pop(context, false),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppButton(
                label: AppStrings.delete,
                icon: Icons.delete_outline_rounded,
                variant: AppButtonVariant.danger,
                onPressed: () => Navigator.pop(context, true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
