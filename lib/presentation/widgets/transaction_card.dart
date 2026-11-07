import 'package:flutter/material.dart';

import '../../core/theme/app_colors_context.dart';
import '../../core/theme/app_radius.dart';
import '../../domain/entities/transaction_entity.dart';
import 'transaction_tile.dart';

/// One transaction row in its own card; used as a ListView.builder item.
class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transaction, required this.onTap});

  final TransactionEntity transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: AppRadius.lgAll,
          border: Border.all(color: c.border),
          boxShadow: c.cardShadow,
        ),
        child: TransactionTile(transaction: transaction, onTap: onTap),
      ),
    );
  }
}
