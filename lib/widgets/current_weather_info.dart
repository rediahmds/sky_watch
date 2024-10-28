import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
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
          final weather = snapshot.data;
          final tempFeelsLike =
              NumberFormat('#').format(weather!.temperature!.celsius);
          final humidity = NumberFormat('#.#').format(weather.humidity);
          final windSpeed = weather.windSpeed;

          const valueStyle =
              TextStyle(color: Color(0xffffe142), fontSize: 24.0);
          const metricStyle =
              TextStyle(color: Color(0xffffe142), fontSize: 14.0);

          return Column(
            children: <Widget>[
              Text(_capitalizeFirstLetter(weather.weatherDescription!)),
              Image.network(swWeather.fetchWeatherIconURL(
                  weatherIconCode: weather.weatherIcon!)),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10.0)),
                padding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedCelsius,
                            color: Color(0xffffe142),
                            size: 40.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            tempFeelsLike,
                            style: valueStyle,
                          ),
                        ), // optional: add degree icon °
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            'Temperature',
                            style: metricStyle,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedHumidity,
                            color: Color(0xffffe142),
                            size: 40.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            '$humidity%',
                            style: valueStyle,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            'Humidity',
                            style: metricStyle,
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedFastWind,
                            color: Color(0xffffe142),
                            size: 40.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            '${windSpeed.toString()}m/s',
                            style: valueStyle,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                          child: Text(
                            'Wind',
                            style: metricStyle,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: const Text('5 Days Weather Forecasts'),
              ),
              const SizedBox(
                height: 25.0,
              )
            ],
          );
        }

        return const Text('Failed to retrieve weather information.');
      },
    );
  }

  String _capitalizeFirstLetter(String input) {
    return input.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
