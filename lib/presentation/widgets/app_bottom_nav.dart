import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_colors_context.dart';
import '../state/shell_controller.dart';
import 'bottom_nav_tab.dart';
import 'notched_bar_painter.dart';

/// Notched bar for the Home and History tabs. The Add FAB docks into the notch.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, required this.currentIndex, required this.onTab});

  final int currentIndex;
  final ValueChanged<int> onTab;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: SizedBox(
          height: 84,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                right: 0,
                top: 8,
                height: 76,
                child: CustomPaint(painter: NotchedBarPainter(c.navBg)),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 26,
                height: 54,
                child: Row(
                  children: [
                    Expanded(
                      child: BottomNavTab(
                        icon: Icons.home_outlined,
                        activeIcon: Icons.home_rounded,
                        label: AppStrings.navHome,
                        active: currentIndex == ShellController.homeTab,
                        onTap: () => onTab(ShellController.homeTab),
                      ),
                    ),
                    const SizedBox(width: 92),
                    Expanded(
                      child: BottomNavTab(
                        icon: Icons.format_list_bulleted_rounded,
                        activeIcon: Icons.format_list_bulleted_rounded,
                        label: AppStrings.navHistory,
                        active: currentIndex == ShellController.historyTab,
                        onTap: () => onTab(ShellController.historyTab),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
