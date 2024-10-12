import 'package:flutter/material.dart';
import 'package:sky_watch/widgets/current_date_day.dart';
import 'package:sky_watch/widgets/current_location.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CurrentDateAndDay(),
                CurrentLocation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
