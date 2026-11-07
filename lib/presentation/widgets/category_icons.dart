import 'package:flutter/material.dart';

import '../../domain/entities/category.dart';

/// Maps each [Category] to its Material icon.
extension CategoryIcon on Category {
  IconData get icon => switch (this) {
        Category.food => Icons.restaurant_rounded,
        Category.transport => Icons.directions_car_filled_outlined,
        Category.shopping => Icons.shopping_bag_outlined,
        Category.bills => Icons.receipt_long_outlined,
        Category.rent => Icons.home_outlined,
        Category.health => Icons.favorite_border_rounded,
        Category.entertainment => Icons.movie_outlined,
        Category.otherExpense => Icons.sell_outlined,
        Category.salary => Icons.payments_outlined,
        Category.freelance => Icons.work_outline_rounded,
        Category.otherIncome => Icons.sell_outlined,
      };
}
