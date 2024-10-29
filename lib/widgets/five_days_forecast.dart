import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sky_watch/services/instances.dart';
import 'package:weather/weather.dart';

class FiveDaysForecast extends StatelessWidget {
  final double latitude;
  final double longitude;

  const FiveDaysForecast({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Weather>>(
      future: swWeather.fetchWeatherForecastByCoord(
        latitude: latitude,
        longitude: longitude,
        fiveDays: true,
      ),
      builder: (BuildContext context, AsyncSnapshot<List<Weather>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Fetching forecast information. Please wait...');
        }

        if (snapshot.hasError) {
          return Text(
            'Failed to fetch forecast information with error ${snapshot.error}',
          );
        }

        if (snapshot.hasData) {
          final result = snapshot.data;

          return LayoutBuilder(
            builder: (context, constraints) {
              double containerHeight = constraints.maxWidth > 600 ? 250 : 210;

              return Center(
                child: Container(
                  height: containerHeight,
                  // Set a minimum width to force horizontal scrolling
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth > 600 ? 800 : 600,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: result!.map((weather) {
                        final iconUrl = swWeather.fetchWeatherIconURL(
                          weatherIconCode: weather.weatherIcon!,
                          size: 2,
                        );
                        final dateAndMonth =
                            swDt.showDateMonthOnly(weather.date!);
                        final temperature = NumberFormat('#')
                            .format(weather.temperature!.celsius);

                        return Container(
                          width: constraints.maxWidth > 600
                              ? 120
                              : constraints.maxWidth * 0.25,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('$temperature°C'),
                              Image.network(iconUrl),
                              Text(dateAndMonth),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return const Text(
          'Something went wrong while trying to fetch forecast data.\nPlease contact the app publisher.',
        );
      },
    );
  }
}
