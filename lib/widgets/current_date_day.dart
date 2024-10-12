import 'package:flutter/material.dart';
import 'package:sky_watch/services/date.dart';

class CurrentDateAndDay extends StatelessWidget {
  const CurrentDateAndDay({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(SkyWatchDateTime().getDateAndDay());
  }
}
