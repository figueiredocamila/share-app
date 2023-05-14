import 'package:intl/intl.dart';

class DateUtil {
  static String formatDateTime(DateTime dateTime, String format) {
    final formatter = DateFormat(format);
    return formatter.format(dateTime);
  }
}
