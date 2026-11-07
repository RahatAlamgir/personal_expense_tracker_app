import '../entities/transaction_entity.dart';
import '../entities/transaction_type.dart';

/// Expense totals for the 7 days ending on [today], oldest first.
class CalculateWeeklySpending {
  const CalculateWeeklySpending();

  List<double> call(List<TransactionEntity> transactions, DateTime today) {
    final end = DateTime(today.year, today.month, today.day);
    final totals = List<double>.filled(7, 0);
    for (final t in transactions) {
      if (t.type != TransactionType.expense) continue;
      final day = DateTime(t.date.year, t.date.month, t.date.day);
      final ago = end.difference(day).inDays;
      if (ago >= 0 && ago < 7) totals[6 - ago] += t.amount;
    }

    return totals;
  }
}
