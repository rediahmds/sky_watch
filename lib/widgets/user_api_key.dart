import 'package:flutter/material.dart';
import 'package:sky_watch/services/user_config.dart';

class UserAPIkeyForm extends StatefulWidget {
  const UserAPIkeyForm({super.key});

  @override
  State<UserAPIkeyForm> createState() => _UserAPIkeyFormState();
}

class _UserAPIkeyFormState extends State<UserAPIkeyForm> {
  final _controller = TextEditingController();
  late bool _isTextFieldEnabled;
  late String _userAPIkey;

  @override
  void initState() {
    super.initState();
    _isTextFieldEnabled = UserConfig().isTextFieldEnabled ?? false;
    _userAPIkey = UserConfig().apiKey ?? '';
    if (_userAPIkey.isNotEmpty) {
      _controller.text = _userAPIkey;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Use your own API key'),
              Switch(
                  value: _isTextFieldEnabled,
                  onChanged: _toggleTextFieldEnabled),
            ],
          ),
          TextField(
            enabled: _isTextFieldEnabled,
            controller: _controller,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Enter your OpenWeather Map API key'),
            onSubmitted: (String apiKey) {
              setState(() {
                _userAPIkey = _controller.text;
                UserConfig().apiKey = _userAPIkey;
              });
            },
          ),
        ],
      ),
    );
  }

  void _toggleTextFieldEnabled(bool value) {
    setState(() {
      _isTextFieldEnabled = value;
      UserConfig().isTextFieldEnabled = _isTextFieldEnabled;
    });
  }
}
