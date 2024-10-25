import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sky_watch/services/instances.dart';
import 'package:weather/weather.dart';

class Forecast extends StatelessWidget {
  final Color primaryColor;
  final Future<Position> position;

  const Forecast(
      {super.key, required this.primaryColor, required this.position});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Forecast'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left_rounded)),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
          child: FutureBuilder<Position>(
              future: position,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  final latitude = snapshot.data!.latitude;
                  final longitude = snapshot.data!.longitude;

                  return FutureBuilder<List<Weather>>(
                      future: swWeather.fetchWeatherForecastByCoord(
                          latitude: latitude, longitude: longitude),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Weather>> forecastSnapshot) {
                        if (forecastSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (forecastSnapshot.hasData) {
                          final forecast = forecastSnapshot.data!;

                          return ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              final weather = forecast[index];
                              final weatherIcon = weather.weatherIcon!;
                              final iconUrl = swWeather.fetchWeatherIconURL(
                                  weatherIconCode: weatherIcon, size: 2);
                              final date = weather.date!;
                              final temp = NumberFormat('#')
                                  .format(weather.temperature!.celsius);

                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 14.0),
                                color: primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(width: 4.0),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            swDt.getDayName(date),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(swDt.getMonthAndDate(date))
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '$temp°C',
                                            style: const TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                              swDt.getTimeIn12HourFormat(date)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Image.network(iconUrl),
                                          Text(weather.weatherMain!)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: forecast.length,
                          );
                        }

                        return Center(
                          child: Column(
                            children: [
                              const Text('Failed to retrieve forecast data.'),
                              Text(forecastSnapshot.error.toString())
                            ],
                          ),
                        );
                      });
                }

                return Center(
                    child: Column(
                  children: [
                    const Text('Failed to retrieve data.'),
                    Text(snapshot.error.toString()),
                  ],
                ));
              })),
    );
  }
}
