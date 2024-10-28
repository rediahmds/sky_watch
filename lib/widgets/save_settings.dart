import 'package:flutter/material.dart';
import 'package:sky_watch/models/settings_data.dart';
import 'package:sky_watch/services/user_config.dart';

class SaveSettings extends StatelessWidget {
  final SettingsData settingsData;
  final Color primaryColor;

  const SaveSettings(
      {super.key, required this.settingsData, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          UserConfig().apiKey = settingsData.userAPIkeyController.text;
          UserConfig().isTextFieldEnabled = settingsData.isUserAPIkeyEnabled;

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Saved successfully!')));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 66.0)),
        child: Text(
          'Save',
          style: TextStyle(color: primaryColor),
        ));
  }
}
