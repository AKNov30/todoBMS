import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(DateTime date, {String pattern = 'h:mm a-MM/dd/yy'}) {
    final localDate = date.toLocal();
    return DateFormat(pattern).format(localDate);
  }

  static String formatToShortDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatToTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }
}
