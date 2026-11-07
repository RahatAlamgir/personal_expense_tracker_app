/// Whether a transaction brings money in (income) or sends it out (expense).
enum TransactionType {
  income,
  expense;

  bool get isIncome => this == TransactionType.income;
  String get label => isIncome ? 'Income' : 'Expense';
}
