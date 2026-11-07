import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker_app/core/utils/money_formatter.dart';
import 'package:personal_expense_tracker_app/domain/entities/category.dart';
import 'package:personal_expense_tracker_app/domain/entities/transaction_entity.dart';
import 'package:personal_expense_tracker_app/domain/entities/transaction_type.dart';
import 'package:personal_expense_tracker_app/domain/usecases/calculate_summary.dart';
import 'package:personal_expense_tracker_app/domain/usecases/calculate_weekly_spending.dart';
import 'package:personal_expense_tracker_app/presentation/state/history_controller.dart';

TransactionEntity _tx(int id, double a, TransactionType t, DateTime d, {String? title}) {
  return TransactionEntity(
    id: id,
    title: title ?? '$id',
    amount: a,
    type: t,
    category: t.isIncome ? Category.salary : Category.food,
    date: d,
  );
}

void main() {
  group('MoneyFormatter', () {
    test('groups digits the South Asian way', () {
      expect(MoneyFormatter.format(0), '0.00');
      expect(MoneyFormatter.format(850), '850.00');
      expect(MoneyFormatter.format(2340.5), '2,340.50');
      expect(MoneyFormatter.format(97000), '97,000.00');
      expect(MoneyFormatter.format(1245000), '12,45,000.00');
      expect(MoneyFormatter.format(123456789), '12,34,56,789.00');
    });

    test('compacts lakh and crore', () {
      expect(MoneyFormatter.compact(97000), '97,000.00');
      expect(MoneyFormatter.compact(9840000), '98.4 L');
      expect(MoneyFormatter.compact(12500000), '1.25 Cr');
    });
  });

  group('analytics', () {
    test('summary totals income, expense and balance', () {
      final now = DateTime(2026, 11, 7);
      final s = const CalculateSummary().call([
        _tx(1, 1000, TransactionType.income, now),
        _tx(2, 250, TransactionType.expense, now),
      ]);
      expect(s.totalIncome, 1000);
      expect(s.totalExpense, 250);
      expect(s.balance, 750);
    });

    test('weekly spending puts today in the last slot', () {
      final today = DateTime(2026, 11, 7, 15);
      final w = const CalculateWeeklySpending().call([
        _tx(1, 100, TransactionType.expense, DateTime(2026, 11, 7)),
        _tx(2, 40, TransactionType.expense, DateTime(2026, 11, 1)),
        _tx(3, 999, TransactionType.expense, DateTime(2026, 10, 20)),
        _tx(4, 500, TransactionType.income, DateTime(2026, 11, 7)),
      ], today);
      expect(w.last, 100);
      expect(w.first, 40);
      expect(w.fold<double>(0, (a, b) => a + b), 140);
    });
  });

  group('HistoryController', () {
    final day = DateTime(2026, 11, 7);
    final all = [
      _tx(1, 100, TransactionType.expense, day, title: 'Groceries'),
      _tx(2, 900, TransactionType.income, day, title: 'Salary'),
    ];

    test('filters by type and search text', () {
      final h = HistoryController();
      addTearDown(h.dispose);
      expect(h.apply(all), hasLength(2));
      h.toggleType(TransactionType.income);
      expect(h.apply(all).single.title, 'Salary');
      h.clearAll();
      h.search.text = 'groc';
      expect(h.apply(all).single.title, 'Groceries');
    });
  });
}
