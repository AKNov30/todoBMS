import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(DateTime? date, {String pattern = 'h:mm a-MM/dd/yy'}) {
    final localDate = date?.toLocal();
    if (date == null) {
      return '';
    }
    return DateFormat(pattern).format(localDate!);
  }
}
