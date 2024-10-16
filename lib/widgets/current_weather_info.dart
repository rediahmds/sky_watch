import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sky_watch/services/instances.dart'; // Your weather service
import 'package:weather/weather.dart';

class CurrentWeatherInfo extends StatelessWidget {
  final double latitude;
  final double longitude;

  const CurrentWeatherInfo(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: swWeather.fetchCurrentWeatherByCoord(
          latitude: latitude, longitude: longitude),
      builder: (BuildContext context, AsyncSnapshot<Weather> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Fetching weather information...'); // Show loading
        }

        if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error if fetching failed
        }

        if (snapshot.hasData) {
          final Weather? weather = snapshot.data;
          return Column(
            children: <Widget>[
              Image.network(
                  swWeather.fetchWeatherIconURL(weather!.weatherIcon!)),
              Text(weather.weatherDescription ?? 'No description'),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: const Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text('Five days forecast'),
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowRight02,
                          color: Colors.black,
                          size: 28.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Text('Failed to retrieve weather information.');
      },
    );
  }
}
