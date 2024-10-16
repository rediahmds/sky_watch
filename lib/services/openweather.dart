import 'instances.dart';
import 'package:weather/weather.dart';

class SkyWatchWeather {
  final String apiKey;

  SkyWatchWeather({required this.apiKey});

  final String baseUrl = 'https://api.openweathermap.org';

  // use `late` to ensure the api key has initialized
  late WeatherFactory wf = WeatherFactory(apiKey);

  Future<String?> fetchCurrentCityNameByCoord(
      {required double latitude, required double longitude}) async {
    try {
      final Weather response =
          await wf.currentWeatherByLocation(latitude, longitude);

      return response.areaName;
    } on OpenWeatherAPIException catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  Future<Weather> fetchCurrentWeatherByCoord(
      {required double latitude, required double longitude}) async {
    final currentWeather = wf.currentWeatherByLocation(latitude, longitude);
    return currentWeather;
  }

  String fetchWeatherIconURL(String weatherIconCode) {
    return 'https://openweathermap.org/img/wn/$weatherIconCode@4x.png';
  }
}
