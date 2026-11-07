import 'package:flutter/foundation.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_summary.dart';
import '../../domain/usecases/add_transaction.dart';
import '../../domain/usecases/calculate_summary.dart';
import '../../domain/usecases/calculate_weekly_spending.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/update_transaction.dart';

/// Holds the loaded transactions and exposes add / update / delete to the UI. Every change
/// reloads the list so all screens update.
class TransactionController extends ChangeNotifier {
  TransactionController({
    required this.getTransactions,
    required this.addTransaction,
    required this.updateTransaction,
    required this.deleteTransaction,
    this.calculateSummary = const CalculateSummary(),
    this.calculateWeeklySpending = const CalculateWeeklySpending(),
  });

  final GetTransactions getTransactions;
  final AddTransaction addTransaction;
  final UpdateTransaction updateTransaction;
  final DeleteTransaction deleteTransaction;
  final CalculateSummary calculateSummary;
  final CalculateWeeklySpending calculateWeeklySpending;

  List<TransactionEntity> _transactions = const [];
  bool _loading = true;

  /// All transactions, newest first.
  List<TransactionEntity> get transactions => _transactions;

  /// True until the first load finishes.
  bool get isLoading => _loading;

  /// Totals for the dashboard cards, recalculated from [transactions].
  TransactionSummary get summary => calculateSummary(_transactions);

  /// Expense totals for the last 7 days, oldest first.
  List<double> get weeklySpending =>
      calculateWeeklySpending(_transactions, DateTime.now());

  /// The transaction with [id], or null (for example right after it was deleted).
  TransactionEntity? byId(int id) {
    for (final t in _transactions) {
      if (t.id == id) return t;
    }

    return null;
  }

  /// Reloads everything from storage and notifies listeners.
  Future<void> load() async {
    _transactions = await getTransactions();
    _loading = false;
    notifyListeners();
  }

  /// Stores [transaction], then reloads.
  Future<void> add(TransactionEntity transaction) async {
    await addTransaction(transaction);
    await load();
  }

  /// Saves changes to [transaction], then reloads.
  Future<void> update(TransactionEntity transaction) async {
    await updateTransaction(transaction);
    await load();
  }

  /// Deletes the transaction with [id], then reloads.
  Future<void> delete(int id) async {
    await deleteTransaction(id);
    await load();
  }
}
