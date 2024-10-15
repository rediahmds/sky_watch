import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sky_watch/models/openweather.dart';

class SkyWatchWeather {
  final String apiKey;
  final double latitude;
  final double longitude;
  SkyWatchWeather(
      {required this.latitude, required this.longitude, required this.apiKey});

  final Dio _dio = Dio();
  final String baseUrl = 'https://api.openweathermap.org';

  Future<String> fetchCityNameByCoordinate() async {
    try {
      final response = await _dio.get('$baseUrl/geo/1.0/reverse?',
          queryParameters: {
            'lat': latitude,
            'lon': longitude,
            'limit': 2,
            'appid': apiKey
          });
      final data = response.data[0];
      final String cityName = OpenWeatherReverseGeocoding.fromJson(data).name;
      return cityName;
    } on DioException catch (e) {
      final logger = Logger(
        printer: PrettyPrinter(),
      );
      if (e.response != null) {
        logger.e('Data: ${e.response?.data}');
        logger.e('Message: ${e.message}');
        logger.e('Resp. Message: ${e.response?.statusMessage}');
      } else {
        logger.e('Error: $e');
      }

      rethrow;
    }
  }
}
