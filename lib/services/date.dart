import 'package:intl/intl.dart';

class SkyWatchDateTime {
  String getDateAndDay() {
    DateTime now = DateTime.now();
    return DateFormat('d MMM, EEEE').format(now);
  }
}
