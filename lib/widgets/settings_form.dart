import 'package:flutter/material.dart';
import 'package:sky_watch/models/settings_data.dart';
import 'package:sky_watch/services/user_config.dart';
import 'package:sky_watch/widgets/save_settings.dart';

class UserSettingsForm extends StatefulWidget {
  final Color primaryColor;
  const UserSettingsForm({super.key, required this.primaryColor});

  @override
  State<UserSettingsForm> createState() => _UserSettingsFormState();
}

class _UserSettingsFormState extends State<UserSettingsForm> {
  // Controllers for the text fields
  final _apiKeyController = TextEditingController();

  // State variables for switches and values
  late bool _isTextFieldEnabled;
  late String _userAPIkey;

  @override
  void initState() {
    super.initState();

    // Initialize values from UserConfig
    _isTextFieldEnabled = UserConfig().isTextFieldEnabled ?? false;
    _userAPIkey = UserConfig().apiKey ?? '';

    // Pre-fill API key field if saved
    if (_userAPIkey.isNotEmpty) {
      _apiKeyController.text = _userAPIkey;
    }
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SettingsData data = SettingsData(
        isUserAPIkeyEnabled: _isTextFieldEnabled,
        userAPIkeyController: _apiKeyController);

    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // API Key Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Use your own API key'),
              Switch(
                value: _isTextFieldEnabled,
                onChanged: _toggleTextFieldEnabled,
              ),
            ],
          ),
          TextField(
            enabled: _isTextFieldEnabled,
            controller: _apiKeyController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Enter your OpenWeather Map API key',
            ),
            onSubmitted: (String apiKey) {
              setState(() {
                _userAPIkey = _apiKeyController.text;
                UserConfig().apiKey = _userAPIkey;
              });
            },
          ),

          const SizedBox(height: 24.0),

          const SizedBox(height: 18.0),
          SaveSettings(settingsData: data, primaryColor: widget.primaryColor)
        ],
      ),
    );
  }

  // Toggle for API key switch
  void _toggleTextFieldEnabled(bool value) {
    setState(() {
      _isTextFieldEnabled = value;
      UserConfig().isTextFieldEnabled = _isTextFieldEnabled;
    });
  }
}
