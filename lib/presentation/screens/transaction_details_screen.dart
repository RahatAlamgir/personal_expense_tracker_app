import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/date_formatter.dart';
import '../../core/utils/money_formatter.dart';
import '../../domain/entities/transaction_entity.dart';
import '../navigation/app_navigator.dart';
import '../state/transaction_controller.dart';
import '../widgets/amount_text.dart';
import '../widgets/app_button.dart';
import '../widgets/app_button_variant.dart';
import '../widgets/app_card.dart';
import '../widgets/app_screen_bar.dart';
import '../widgets/category_icons.dart';
import '../widgets/delete_dialog.dart';
import '../widgets/details_row.dart';
import '../widgets/success_snack_bar.dart';

/// Full details of one transaction, with Edit and Delete actions.
class TransactionDetailsScreen extends StatelessWidget {
  const TransactionDetailsScreen({super.key, required this.transactionId});

  final int transactionId;

  /// Asks for confirmation, then deletes and closes the screen.
  Future<void> _delete(BuildContext context, TransactionEntity tx) async {
    final controller = context.read<TransactionController>();
    final confirmed = await DeleteDialog.confirm(context, tx);
    if (!confirmed || !context.mounted) return;
    showSuccessSnackBar(context, AppStrings.deleted);
    Navigator.pop(context);
    await controller.delete(tx.id!);
  }

  @override
  Widget build(BuildContext context) {
    final tx = context.watch<TransactionController>().byId(transactionId);
    if (tx == null) return const Scaffold();

    final c = context.colors;
    final t = Theme.of(context).textTheme;
    final isIncome = tx.type.isIncome;
    final accent = isIncome ? c.income : c.expense;
    final soft = isIncome ? c.incomeSoft : c.expenseSoft;
    final arrow = isIncome ? Icons.south_west_rounded : Icons.north_east_rounded;

    return Scaffold(
      appBar: buildScreenBar(context, AppStrings.detailsTitle),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.s2,
          AppSpacing.screen,
          AppSpacing.s6,
        ),
        children: [
          AppCard(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(color: soft, borderRadius: AppRadius.xlAll),
                  child: Icon(tx.category.icon, size: 32, color: accent),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(color: soft, borderRadius: AppRadius.fullAll),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(arrow, size: 14, color: accent),
                      const SizedBox(width: 4),
                      Text(
                        tx.type.label,
                        style: t.labelSmall!.copyWith(color: accent, letterSpacing: 0.2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(tx.title, textAlign: TextAlign.center, style: t.titleMedium),
                const SizedBox(height: 10),
                AmountText(
                  tx.amount,
                  sign: isIncome ? AppStrings.plus : MoneyFormatter.minus,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: t.displayMedium!.copyWith(color: accent),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
            child: Column(
              children: [
                DetailsRow(
                  icon: Icons.sell_outlined,
                  label: AppStrings.categoryLabel,
                  value: tx.category.label,
                ),
                Divider(color: c.border),
                DetailsRow(icon: arrow, label: AppStrings.typeLabel, value: tx.type.label),
                Divider(color: c.border),
                DetailsRow(
                  icon: Icons.calendar_today_outlined,
                  label: AppStrings.dateLabel,
                  value: DateFormatter.full(tx.date),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.screen, 12, AppSpacing.screen, 16),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  label: AppStrings.edit,
                  icon: Icons.edit_outlined,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => AppNavigator.openEdit(context, tx),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AppButton(
                  label: AppStrings.delete,
                  icon: Icons.delete_outline_rounded,
                  variant: AppButtonVariant.dangerOutline,
                  onPressed: () => _delete(context, tx),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
