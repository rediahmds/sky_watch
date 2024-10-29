import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:sky_watch/services/date.dart';
import 'package:sky_watch/services/location.dart';
import 'package:sky_watch/services/openweather.dart';
import 'package:sky_watch/services/user_config.dart';

String? openWeatherApiKey =
    UserConfig().apiKey ?? dotenv.env['OPENWEATHER_API_KEY'];
final ValueNotifier<String?> openWeatherApiKeyNotifier =
    ValueNotifier<String?>(openWeatherApiKey);
final logger = Logger(
  printer: PrettyPrinter(),
);
final SkyWatchDateTime swDt = SkyWatchDateTime();
final SkyWatchGeolocator swGeolocator = SkyWatchGeolocator();
SkyWatchWeather swWeather = SkyWatchWeather(apiKey: openWeatherApiKey!);
