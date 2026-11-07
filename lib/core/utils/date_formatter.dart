/// Date helpers that produce the display formats used in the app (e.g. `7 Nov 2026`).
abstract final class DateFormatter {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  static const _weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday',
  ];
  static const _weekdayInitials = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  /// Strips the time of day, keeping only the calendar date.
  static DateTime dayOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// 7 Nov 2026
  static String full(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

  /// Saturday, 7 Nov
  static String weekdayAndDay(DateTime d) =>
      '${_weekdays[d.weekday - 1]}, ${d.day} ${_months[d.month - 1]}';

  /// One-letter weekday used under the weekly chart.
  static String weekdayInitial(DateTime d) => _weekdayInitials[d.weekday - 1];

  /// Today · 7 Nov, Yesterday · 6 Nov, otherwise 5 Nov (with year if not this year).
  static String groupHeader(DateTime d, DateTime now) {
    final day = dayOnly(d);
    final today = dayOnly(now);
    final short = '${d.day} ${_months[d.month - 1]}';
    final diff = today.difference(day).inDays;
    if (diff == 0) return 'Today · $short';
    if (diff == 1) return 'Yesterday · $short';

    return d.year == now.year ? short : '$short ${d.year}';
  }
}
