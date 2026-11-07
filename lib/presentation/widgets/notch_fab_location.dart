import 'package:flutter/material.dart';

/// Centres the FAB in the bottom bar's notch (4px below the bar's top edge).
class NotchFabLocation extends FloatingActionButtonLocation {
  const NotchFabLocation();

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry geometry) {
    final x = (geometry.scaffoldSize.width - geometry.floatingActionButtonSize.width) / 2;
    final y = geometry.contentBottom + 4;

    return Offset(x, y);
  }
}
