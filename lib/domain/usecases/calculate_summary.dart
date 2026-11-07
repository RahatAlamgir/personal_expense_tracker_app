import '../entities/transaction_entity.dart';
import '../entities/transaction_summary.dart';

/// Adds up income and expenses to produce the dashboard summary.
class CalculateSummary {
  const CalculateSummary();

  TransactionSummary call(List<TransactionEntity> transactions) {
    var income = 0.0;
    var expense = 0.0;
    for (final t in transactions) {
      if (t.type.isIncome) {
        income += t.amount;
      } else {
        expense += t.amount;
      }
    }

    return TransactionSummary(totalIncome: income, totalExpense: expense);
  }
}
