import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/money_formatter.dart';
import 'amount_text.dart';

/// Large Current Balance card shown at the top of Home.
class BalanceHero extends StatelessWidget {
  const BalanceHero({super.key, required this.balance, required this.caption});

  final double balance;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s5),
      decoration: BoxDecoration(color: c.hero, borderRadius: AppRadius.xlAll),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: c.heroOverlay,
                  borderRadius: AppRadius.mdAll,
                ),
                child: Icon(Icons.account_balance_wallet_outlined, size: 20, color: c.onHero),
              ),
              const SizedBox(width: 10),
              Text(
                AppStrings.currentBalance,
                style: t.bodyMedium!.copyWith(color: c.onHero, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: AmountText(
              balance.abs(),
              sign: balance < 0 ? MoneyFormatter.minus : '',
              style: t.displayLarge!.copyWith(color: c.onHero),
            ),
          ),
          const SizedBox(height: 4),
          Text(caption, style: t.bodySmall!.copyWith(color: c.onHero.withValues(alpha: 0.88))),
        ],
      ),
    );
  }
}
