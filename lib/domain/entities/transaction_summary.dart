/// Totals across all transactions: income, expense and the resulting balance.
class TransactionSummary {
  const TransactionSummary({required this.totalIncome, required this.totalExpense});

  static const empty = TransactionSummary(totalIncome: 0, totalExpense: 0);

  final double totalIncome;
  final double totalExpense;

  double get balance => totalIncome - totalExpense;
}
