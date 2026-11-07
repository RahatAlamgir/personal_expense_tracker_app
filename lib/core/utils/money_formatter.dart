/// Formats taka amounts using the South Asian grouping (12,45,000.00).
abstract final class MoneyFormatter {
  /// Bangladeshi taka sign.
  static const taka = '৳';
  /// True minus sign (U+2212), used instead of a hyphen for expenses.
  static const minus = '−';

  /// Two decimals, South Asian grouping: 1245000 becomes `12,45,000.00`.
  static String format(double value) {
    final fixed = value.abs().toStringAsFixed(2);
    final parts = fixed.split('.');
    final digits = parts[0];
    final String grouped;
    if (digits.length <= 3) {
      grouped = digits;
    } else {
      final head = digits.substring(0, digits.length - 3);
      final tail = digits.substring(digits.length - 3);
      final buf = StringBuffer();
      for (var i = 0; i < head.length; i++) {
        if (i > 0 && (head.length - i).isEven) buf.write(',');
        buf.write(head[i]);
      }
      grouped = '$buf,$tail';
    }

    return '$grouped.${parts[1]}';
  }

  /// 1.25 Cr / 98.4 L for values from one lakh up; full format below that.
  static String compact(double value) {
    final abs = value.abs();
    final sign = value < 0 ? minus : '';
    String trim(double v) => v.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0+$'), '');
    if (abs >= 10000000) return '$sign${trim(abs / 10000000)} Cr';
    if (abs >= 100000) return '$sign${trim(abs / 100000)} L';

    return '$sign${format(abs)}';
  }
}
