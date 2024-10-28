import 'package:flutter/material.dart';

class SettingsData {
  final TextEditingController userAPIkeyController;

  final bool isUserAPIkeyEnabled;

  const SettingsData(
      {required this.isUserAPIkeyEnabled, required this.userAPIkeyController});
}
