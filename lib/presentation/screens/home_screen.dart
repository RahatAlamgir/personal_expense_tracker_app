import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/date_formatter.dart';
import '../navigation/app_navigator.dart';
import '../state/shell_controller.dart';
import '../state/transaction_controller.dart';
import '../widgets/balance_hero.dart';
import '../widgets/empty_state.dart';
import '../widgets/summary_pair.dart';
import '../widgets/theme_button.dart';
import '../widgets/transaction_card.dart';
import '../widgets/weekly_spending_card.dart';

/// Dashboard: balance, income and expense cards, weekly spending and recent transactions.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Everything above the transaction rows.
  List<Widget> _headerItems(BuildContext context, TransactionController controller) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;
    final hasData = controller.transactions.isNotEmpty;
    final summary = controller.summary;

    return [
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormatter.weekdayAndDay(DateTime.now()),
                  style: t.bodySmall!.copyWith(color: c.inkMuted),
                ),
                Text(AppStrings.appName, style: t.titleLarge),
              ],
            ),
          ),
          const ThemeButton(),
        ],
      ),
      const SizedBox(height: AppSpacing.s5),
      BalanceHero(
        balance: summary.balance,
        caption: hasData ? AppStrings.balanceCaption : AppStrings.balanceCaptionEmpty,
      ),
      const SizedBox(height: AppSpacing.s5),
      SummaryPair(summary: summary),
      if (hasData) ...[
        const SizedBox(height: AppSpacing.s5),
        WeeklySpendingCard(daily: controller.weeklySpending),
      ],
      const SizedBox(height: AppSpacing.s5),
      Row(
        children: [
          Expanded(child: Text(AppStrings.recentTransactions, style: t.titleSmall)),
          if (hasData)
            TextButton(
              onPressed: () =>
                  context.read<ShellController>().select(ShellController.historyTab),
              style: TextButton.styleFrom(
                foregroundColor: c.primary,
                minimumSize: const Size(48, 40),
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppStrings.seeAll, style: t.labelLarge!.copyWith(fontSize: 14)),
                  const Icon(Icons.chevron_right_rounded, size: 20),
                ],
              ),
            ),
        ],
      ),
      const SizedBox(height: AppSpacing.s2),
      if (!hasData)
        EmptyState(
          icon: Icons.inbox_outlined,
          title: AppStrings.noTransactionsTitle,
          message: AppStrings.noTransactionsHome,
          actionLabel: AppStrings.addTransactionButton,
          actionIcon: Icons.add_rounded,
          onAction: () => AppNavigator.openAdd(context),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TransactionController>();
    if (controller.isLoading) return const Center(child: CircularProgressIndicator());

    final headers = _headerItems(context, controller);
    final recent = controller.transactions.take(4).toList();

    return SafeArea(
      bottom: false,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.s3,
          AppSpacing.screen,
          AppSpacing.s4,
        ),
        itemCount: headers.length + recent.length,
        itemBuilder: (context, index) {
          if (index < headers.length) return headers[index];
          final tx = recent[index - headers.length];

          return TransactionCard(
            transaction: tx,
            onTap: () => AppNavigator.openDetails(context, tx.id!),
          );
        },
      ),
    );
  }
}
