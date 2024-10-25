import 'instances.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart';

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
    } on OpenWeatherAPIException catch (openweatherErr) {
      logger.e(openweatherErr);
      rethrow;
    } on ClientException catch (e) {
      logger.e(e);
      throw 'Error while retrieving city info. Please restart the app.';
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
    } on ClientException catch (e) {
      logger.e(e);
      throw 'Error while requesting weather data. Please close and reopen the app';
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
    } on ClientException catch (e) {
      logger.e(e);
      throw 'Error while retrieving weather forecast information.';
    }
  }
}
