class UserConfig {
  static final UserConfig _instance = UserConfig._internal();
  String? apiKey;
  bool? isTextFieldEnabled;

  factory UserConfig() {
    return _instance;
  }

  UserConfig._internal();
}
