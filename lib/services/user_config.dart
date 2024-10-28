class UserConfig {
  static final UserConfig _instance = UserConfig._internal();
  String? apiKey;
  bool? isTextFieldEnabled;
  bool? isCustomCoordEnabled;

  double? latitude;
  double? longitude;

  factory UserConfig() {
    return _instance;
  }

  UserConfig._internal();
}
