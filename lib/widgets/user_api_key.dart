import 'package:flutter/material.dart';

class UserAPIkeyForm extends StatefulWidget {
  const UserAPIkeyForm({super.key});

  @override
  State<UserAPIkeyForm> createState() => _UserAPIkeyFormState();
}

class _UserAPIkeyFormState extends State<UserAPIkeyForm> {
  final _controller = TextEditingController();
  bool _isTextFieldEnabled = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? userAPIkey;

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
                  onChanged: (bool value) {
                    setState(() {
                      _isTextFieldEnabled = value;
                    });
                  }),
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
                userAPIkey = apiKey;
              });
            },
          ),
        ],
      ),
    );
  }
}
