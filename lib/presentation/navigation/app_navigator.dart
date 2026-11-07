import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/transaction_entity.dart';
import '../screens/add_edit_transaction_screen.dart';
import '../screens/app_shell.dart';
import '../screens/transaction_details_screen.dart';
import '../state/transaction_form_controller.dart';

/// Central place for screen transitions so screens never build routes themselves.
abstract final class AppNavigator {
  /// Opens the empty Add form.
  static Future<void> openAdd(BuildContext context) => _openForm(context, null);

  /// Opens the form pre-filled with [transaction].
  static Future<void> openEdit(BuildContext context, TransactionEntity transaction) =>
      _openForm(context, transaction);

  /// Pushes the form with its own [TransactionFormController].
  static Future<void> _openForm(BuildContext context, TransactionEntity? existing) {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => TransactionFormController(existing: existing),
          child: const AddEditTransactionScreen(),
        ),
      ),
    );
  }

  /// Opens the details screen for the transaction with [id].
  static Future<void> openDetails(BuildContext context, int id) {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(builder: (_) => TransactionDetailsScreen(transactionId: id)),
    );
  }

  /// Replaces the splash with the main shell using a fade.
  static void replaceWithShell(BuildContext context) {
    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (_, _, _) => const AppShell(),
        transitionsBuilder: (_, animation, _, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
