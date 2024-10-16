import 'package:flutter/material.dart';
import 'package:sky_watch/services/instances.dart';

class CurrentDateAndDay extends StatelessWidget {
  const CurrentDateAndDay({super.key});
  @override
  Widget build(BuildContext context) {
    return Text(swDt.getDateAndDay());
  }
}
