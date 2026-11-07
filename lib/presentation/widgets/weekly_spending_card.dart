import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/utils/date_formatter.dart';
import 'amount_text.dart';
import 'app_card.dart';

/// Seven bars, oldest first; the last bar is today.
class WeeklySpendingCard extends StatelessWidget {
  const WeeklySpendingCard({super.key, required this.daily});

  final List<double> daily;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;
    final total = daily.fold<double>(0, (a, b) => a + b);
    final maxValue = daily.fold<double>(0, (a, b) => a > b ? a : b);
    final today = DateTime.now();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(AppStrings.spendingThisWeek, style: t.titleSmall)),
              AmountText(total, compact: true, style: t.labelLarge!),
            ],
          ),
          const SizedBox(height: 14),
          Semantics(
            label: AppStrings.weeklyChartLabel,
            child: SizedBox(
              height: 96,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < daily.length; i++) ...[
                    if (i > 0) const SizedBox(width: 10),
                    Expanded(
                      child: FractionallySizedBox(
                        heightFactor:
                            maxValue == 0 ? 0.08 : (daily[i] / maxValue).clamp(0.08, 1.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: i == daily.length - 1 ? c.primary : c.primarySoft,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(AppRadius.sm),
                              bottom: Radius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              for (var i = 0; i < daily.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    DateFormatter.weekdayInitial(
                      today.subtract(Duration(days: daily.length - 1 - i)),
                    ),
                    textAlign: TextAlign.center,
                    style: t.bodySmall!.copyWith(
                      color: c.inkMuted,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
