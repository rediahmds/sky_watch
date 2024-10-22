import 'package:intl/intl.dart';

class SkyWatchDateTime {
  String getDateAndDay() {
    DateTime now = DateTime.now();
    return DateFormat('d MMM, EEEE').format(now);
  }

  String showDateMonthOnly(DateTime date) => DateFormat('d MMM').format(date);

  String showTimeOnly(DateTime date) => DateFormat('HH:mm').format(date);
}
