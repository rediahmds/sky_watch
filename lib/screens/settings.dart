import 'package:flutter/material.dart';
import 'package:sky_watch/widgets/user_api_key.dart';

class Settings extends StatelessWidget {
  final Color primaryColor;

  const Settings({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Settings'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded)),
      ),
      backgroundColor: primaryColor,
      body: const Column(
        children: [
          UserAPIkeyForm(),
        ],
      ),
    );
  }
}
