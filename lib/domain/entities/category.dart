import 'transaction_type.dart';

/// Transaction categories. Each belongs to exactly one [TransactionType] and carries its
/// display label.
enum Category {
  food('Food & Groceries', TransactionType.expense),
  transport('Transport', TransactionType.expense),
  shopping('Shopping', TransactionType.expense),
  bills('Bills & Utilities', TransactionType.expense),
  rent('Rent', TransactionType.expense),
  health('Health', TransactionType.expense),
  entertainment('Entertainment', TransactionType.expense),
  otherExpense('Other', TransactionType.expense),
  salary('Salary', TransactionType.income),
  freelance('Freelance', TransactionType.income),
  otherIncome('Other', TransactionType.income);

  const Category(this.label, this.type);

  final String label;
  final TransactionType type;

  static List<Category> forType(TransactionType type) =>
      values.where((c) => c.type == type).toList();
}
