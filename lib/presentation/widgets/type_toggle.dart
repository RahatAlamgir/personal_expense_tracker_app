import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../domain/entities/transaction_type.dart';

/// Expense / Income segmented control; each option has its own colour, arrow and outline.
class TypeToggle extends StatelessWidget {
  const TypeToggle({super.key, required this.value, required this.onChanged});

  final TransactionType value;
  final ValueChanged<TransactionType> onChanged;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: c.surfaceSunken, borderRadius: AppRadius.lgAll),
      child: Row(
        children: [
          Expanded(child: _option(context, TransactionType.expense)),
          const SizedBox(width: 6),
          Expanded(child: _option(context, TransactionType.income)),
        ],
      ),
    );
  }

  Widget _option(BuildContext context, TransactionType type) {
    final c = context.colors;
    final selected = value == type;
    final accent = type.isIncome ? c.income : c.expense;
    final soft = type.isIncome ? c.incomeSoft : c.expenseSoft;

    return Semantics(
      button: true,
      selected: selected,
      label: type.label,
      child: Material(
        color: selected ? soft : c.transparent,
        borderRadius: AppRadius.mdAll,
        child: InkWell(
          borderRadius: AppRadius.mdAll,
          onTap: () => onChanged(type),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: AppRadius.mdAll,
              border: Border.all(color: selected ? accent : c.transparent, width: 1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type.isIncome ? Icons.south_west_rounded : Icons.north_east_rounded,
                  size: 18,
                  color: selected ? accent : c.inkMuted,
                ),
                const SizedBox(width: 8),
                Text(
                  type.label,
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: selected ? accent : c.inkMuted,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
