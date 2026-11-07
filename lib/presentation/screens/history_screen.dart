import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_spacing.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_type.dart';
import '../navigation/app_navigator.dart';
import '../state/history_controller.dart';
import '../state/transaction_controller.dart';
import '../widgets/app_button_variant.dart';
import '../widgets/app_input_decoration.dart';
import '../widgets/category_sheet.dart';
import '../widgets/day_header.dart';
import '../widgets/empty_state.dart';
import '../widgets/filter_chip_button.dart';
import '../widgets/transaction_card.dart';

/// All transactions, grouped by day, with search and type / category filters.
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  /// Title, search field, filter chips and (when there is nothing to list) an empty state.
  List<Widget> _headerItems(
    BuildContext context,
    HistoryController history, {
    required bool noData,
    required bool noMatches,
  }) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;

    return [
      Text(AppStrings.historyTitle, style: t.titleLarge),
      const SizedBox(height: AppSpacing.s4),
      TextField(
        controller: history.search,
        onChanged: history.onQueryChanged,
        textInputAction: TextInputAction.search,
        style: t.bodyLarge,
        decoration: buildInputDecoration(
          context,
          hint: AppStrings.searchHint,
          prefix: Icon(Icons.search_rounded, size: 22, color: c.inkMuted),
          suffix: history.search.text.isEmpty
              ? null
              : IconButton(
                  tooltip: AppStrings.clearSearch,
                  icon: Icon(Icons.close_rounded, size: 20, color: c.inkMuted),
                  onPressed: history.clearSearch,
                ),
        ),
      ),
      const SizedBox(height: AppSpacing.s3),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChipButton(
              label: AppStrings.filterAll,
              selected: history.type == null && history.category == null,
              onTap: history.showAll,
            ),
            const SizedBox(width: 8),
            FilterChipButton(
              label: AppStrings.filterIncome,
              selected: history.type == TransactionType.income,
              onTap: () => history.toggleType(TransactionType.income),
            ),
            const SizedBox(width: 8),
            FilterChipButton(
              label: AppStrings.filterExpense,
              selected: history.type == TransactionType.expense,
              onTap: () => history.toggleType(TransactionType.expense),
            ),
            const SizedBox(width: 8),
            FilterChipButton(
              label: history.category?.label ?? AppStrings.filterCategory,
              selected: history.category != null,
              trailing: Icons.keyboard_arrow_down_rounded,
              onTap: () => showCategorySheet(
                context,
                type: history.type,
                selected: history.category,
                includeAll: true,
                onSelected: history.selectCategory,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: AppSpacing.s4),
      if (noData)
        EmptyState(
          icon: Icons.inbox_outlined,
          title: AppStrings.noTransactionsTitle,
          message: AppStrings.noTransactionsHistory,
          actionLabel: AppStrings.addTransactionButton,
          actionIcon: Icons.add_rounded,
          onAction: () => AppNavigator.openAdd(context),
        )
      else if (noMatches)
        EmptyState(
          icon: Icons.search_rounded,
          title: AppStrings.noMatchesTitle,
          message: AppStrings.noMatchesMessage,
          actionLabel: history.isFiltering ? AppStrings.clearFilters : null,
          actionVariant: AppButtonVariant.secondary,
          onAction: history.clearAll,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final history = context.watch<HistoryController>();
    final all = context.watch<TransactionController>().transactions;
    final items = history.apply(all);
    final groups = history.groupByDay(items);
    final now = DateTime.now();
    final headers = _headerItems(
      context,
      history,
      noData: all.isEmpty,
      noMatches: all.isNotEmpty && items.isEmpty,
    );

    // Flat list of rows: a DateTime marks a day header, a TransactionEntity is a row.
    final rows = <Object>[
      for (final entry in groups.entries) ...[entry.key, ...entry.value],
    ];

    return SafeArea(
      bottom: false,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.s3,
          AppSpacing.screen,
          AppSpacing.s4,
        ),
        itemCount: headers.length + rows.length,
        itemBuilder: (context, index) {
          if (index < headers.length) return headers[index];
          final row = rows[index - headers.length];
          if (row is DateTime) {
            return Padding(
              padding: const EdgeInsets.only(top: AppSpacing.s2),
              child: DayHeader(day: row, items: groups[row]!, now: now),
            );
          }
          final tx = row as TransactionEntity;

          return TransactionCard(
            transaction: tx,
            onTap: () => AppNavigator.openDetails(context, tx.id!),
          );
        },
      ),
    );
  }
}
