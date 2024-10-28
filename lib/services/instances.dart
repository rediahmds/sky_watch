import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:sky_watch/services/date.dart';
import 'package:sky_watch/services/location.dart';
import 'package:sky_watch/services/openweather.dart';
import 'package:sky_watch/services/user_config.dart';

final openWeatherApiKey =
    UserConfig().apiKey ?? dotenv.env['OPENWEATHER_API_KEY'];
final logger = Logger(
  printer: PrettyPrinter(),
);
final SkyWatchDateTime swDt = SkyWatchDateTime();
final SkyWatchGeolocator swGeolocator = SkyWatchGeolocator();
final SkyWatchWeather swWeather = SkyWatchWeather(apiKey: openWeatherApiKey!);
