import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../navigation/app_navigator.dart';
import '../state/shell_controller.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/notch_fab_location.dart';
import 'history_screen.dart';
import 'home_screen.dart';

/// Main scaffold: Home and History tabs, the notched bottom bar and the Add FAB.
class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    final shell = context.watch<ShellController>();

    return Scaffold(
      body: IndexedStack(
        index: shell.index,
        children: const [HomeScreen(), HistoryScreen()],
      ),
      floatingActionButtonLocation: const NotchFabLocation(),
      floatingActionButton: FloatingActionButton(
        tooltip: AppStrings.addTransactionLabel,
        onPressed: () => AppNavigator.openAdd(context),
        child: const Icon(Icons.add_rounded),
      ),
      bottomNavigationBar: AppBottomNav(currentIndex: shell.index, onTab: shell.select),
    );
  }
}
