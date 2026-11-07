import '../utils/money_formatter.dart';

/// Every static piece of user-facing text lives here.
abstract final class AppStrings {
  // Brand
  static const appName = 'Expense Tracker';
  static const tagline = 'Know where every taka goes.';

  // Navigation
  static const navHome = 'Home';
  static const navHistory = 'History';
  static const addTransactionLabel = 'Add transaction';
  static const back = 'Back';

  // Home
  static const currentBalance = 'Current Balance';
  static const balanceCaption = 'Total income minus total expenses';
  static const balanceCaptionEmpty = 'Add your first transaction to get started';
  static const totalIncome = 'Total Income';
  static const totalExpenses = 'Total Expenses';
  static const spendingThisWeek = 'Spending this week';
  static const weeklyChartLabel = 'Daily spending for the last 7 days';
  static const recentTransactions = 'Recent transactions';
  static const seeAll = 'See all';

  // Empty states
  static const noTransactionsTitle = 'No transactions yet';
  static const noTransactionsHome = 'Record your income and expenses to see them here.';
  static const noTransactionsHistory = 'Everything you add will appear here, grouped by date.';
  static const noMatchesTitle = 'No matches';
  static const noMatchesMessage = 'Try a different word or clear the filters.';
  static const clearFilters = 'Clear filters';
  static const addTransactionButton = 'Add transaction';

  // History
  static const historyTitle = 'Transactions';
  static const searchHint = 'Search title or category';
  static const clearSearch = 'Clear search';
  static const filterAll = 'All';
  static const filterIncome = 'Income';
  static const filterExpense = 'Expense';
  static const filterCategory = 'Category';
  static const allCategories = 'All categories';

  // Form
  static const addTitle = 'Add Transaction';
  static const editTitle = 'Edit Transaction';
  static const requiredMark = '*';
  static const requiredLegend = ' Required';
  static const requiredSuffix = ' *';
  static const optionalSuffix = ' (optional)';
  static const amountLabel = 'Amount';
  static const amountHint = '0.00';
  static const titleLabel = 'Title';
  static const titleHint = 'e.g. Grocery shopping';
  static const categoryLabel = 'Category';
  static const categoryPlaceholder = 'Select a category';
  static const dateLabel = 'Date';
  static const datePlaceholder = 'Select a date';
  static const typeLabel = 'Type';
  static const saveButton = 'Save Transaction';
  static const updateButton = 'Update Transaction';
  static const titleRequired = 'Title is required';
  static const categoryRequired = 'Choose a category';
  static const amountInvalid = 'Enter an amount greater than ${MoneyFormatter.taka} 0';

  // Details
  static const detailsTitle = 'Transaction Details';
  static const edit = 'Edit';
  static const delete = 'Delete';

  // Delete dialog
  static const deleteTitle = 'Delete this transaction?';
  static const deleteMessage =
      'This permanently removes it and updates your balance. You can’t undo this.';
  static const cancel = 'Cancel';

  // Snackbars
  static const added = 'Transaction added';
  static const updated = 'Transaction updated';
  static const deleted = 'Transaction deleted';

  // Appearance
  static const themeTooltip = 'Change theme';
  static const themeTitle = 'Appearance';
  static const themeSystem = 'System default';
  static const themeLight = 'Light';
  static const themeDark = 'Dark';

  // Symbols
  static const plus = '+';
  static const thinSpace = ' ';

  static String categoryAndDate(String category, String date) => '$category · $date';

  static String amountWithMeta(String sign, String amount, String date) =>
      '$sign${MoneyFormatter.taka}$thinSpace$amount · $date';
}
