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
    try {
      final currentWeather = wf.currentWeatherByLocation(latitude, longitude);
      return currentWeather;
    } on OpenWeatherAPIException catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  String fetchWeatherIconURL({required String weatherIconCode, int size = 4}) {
    return 'https://openweathermap.org/img/wn/$weatherIconCode@${size}x.png';
  }

  List<Weather> _filterToFiveDays(List<Weather> weatherData) {
    Set<String> uniqueDt = {};
    final List<Weather> fiveDaysWeather = [];
    for (var weather in weatherData) {
      final String key =
          '${weather.date!.year}-${weather.date!.month}-${weather.date!.day}';

      if (uniqueDt.length < 5 && !uniqueDt.contains(key)) {
        uniqueDt.add(key);
        fiveDaysWeather.add(weather);
      }
    }
    return fiveDaysWeather;
  }

  Future<List<Weather>> fetchWeatherForecastByCoord(
      {required double latitude,
      required double longitude,
      bool fiveDays = false}) async {
    try {
      final result = await wf.fiveDayForecastByLocation(latitude, longitude);

      if (fiveDays) {
        final List<Weather> fiveDaysWeather = _filterToFiveDays(result);
        return fiveDaysWeather;
      }

      return result;
    } on OpenWeatherAPIException catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
