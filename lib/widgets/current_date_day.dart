import 'package:flutter/material.dart';
import 'package:sky_watch/services/instances.dart';

class CurrentDateAndDay extends StatelessWidget {
  const CurrentDateAndDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15.0),
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.0),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              swDt.getDateAndDay(),
              style: const TextStyle(color: Color(0xffffe142)),
            )));
  }
}
