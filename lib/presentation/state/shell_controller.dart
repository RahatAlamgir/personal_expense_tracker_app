import 'package:flutter/foundation.dart';

/// Which bottom-navigation tab is showing.
class ShellController extends ChangeNotifier {
  /// Tab indexes used by the bottom navigation.
  static const homeTab = 0;
  static const historyTab = 1;

  int _index = homeTab;

  int get index => _index;

  /// Switches to the tab at [index].
  void select(int index) {
    if (index == _index) return;
    _index = index;
    notifyListeners();
  }
}
