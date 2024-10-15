import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sky_watch/services/location.dart';
import 'package:sky_watch/services/openweather.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  @override
  Widget build(BuildContext context) {
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
    return FutureBuilder(
        future: SkyWatchGeolocator().getCurrentCityLocation(),
        builder: (BuildContext context, AsyncSnapshot<Position?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return const Text(
              'Error while retrieving location info. Please allow the permission',
              style: TextStyle(color: Colors.redAccent),
            );
          }
          if (snapshot.hasData) {
            Position? position = snapshot.data;
            var latitude = position?.latitude;
            var longitude = position?.longitude;
            final openWeatherApiKey = dotenv.env['OPENWEATHER_API_KEY'];

            return FutureBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<dynamic> weatherSnapshot) {
                if (weatherSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading while waiting for API response
                }
                if (weatherSnapshot.hasError) {
                  return const Text(
                      'Error while retrieving city information. Please contact the app publisher');
                }
                if (weatherSnapshot.hasData) {
                  return Text(
                      weatherSnapshot.data); // Display the API response data
                }
                return const Text('Failed to retrieve weather data');
              },
              future: SkyWatchWeather(
                      apiKey: openWeatherApiKey!,
                      latitude: latitude!,
                      longitude: longitude!)
                  .fetchCityNameByCoordinate(),
            );
          }

          return const Text('Failed to retrieve location data');
        });
  }
}
