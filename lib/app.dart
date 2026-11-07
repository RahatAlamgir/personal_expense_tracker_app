import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'domain/repositories/transaction_repository.dart';
import 'domain/usecases/add_transaction.dart';
import 'domain/usecases/delete_transaction.dart';
import 'domain/usecases/get_transactions.dart';
import 'domain/usecases/update_transaction.dart';
import 'presentation/navigation/app_navigator.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/state/history_controller.dart';
import 'presentation/state/shell_controller.dart';
import 'presentation/state/splash_controller.dart';
import 'presentation/state/theme_controller.dart';
import 'presentation/state/transaction_controller.dart';

/// Root widget: wires up the providers (repositories, controllers) and the themed
/// [MaterialApp], starting on the splash screen.
class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({
    super.key,
    required this.repository,
    required this.themeController,
  });

  final TransactionRepository repository;
  final ThemeController themeController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TransactionRepository>.value(value: repository),
        ChangeNotifierProvider<ThemeController>.value(value: themeController),
        ChangeNotifierProvider<TransactionController>(
          create: (context) {
            final repo = context.read<TransactionRepository>();

            return TransactionController(
              getTransactions: GetTransactions(repo),
              addTransaction: AddTransaction(repo),
              updateTransaction: UpdateTransaction(repo),
              deleteTransaction: DeleteTransaction(repo),
            );
          },
        ),
        ChangeNotifierProvider<ShellController>(create: (_) => ShellController()),
        ChangeNotifierProvider<HistoryController>(create: (_) => HistoryController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, theme, _) {
          return MaterialApp(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: theme.themeMode,
            home: ChangeNotifierProvider<SplashController>(
              lazy: false,
              create: (context) => SplashController(
                load: context.read<TransactionController>().load,
                onFinished: () => AppNavigator.replaceWithShell(context),
              )..start(),
              child: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
