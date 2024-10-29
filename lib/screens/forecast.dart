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
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: FutureBuilder<Position>(
          future: position,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              final latitude = snapshot.data!.latitude;
              final longitude = snapshot.data!.longitude;

              return ValueListenableBuilder<String?>(
                valueListenable: openWeatherApiKeyNotifier,
                builder: (context, value, child) {
                  return FutureBuilder<List<Weather>>(
                    future: swWeather.fetchWeatherForecastByCoord(
                        latitude: latitude, longitude: longitude),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Weather>> forecastSnapshot) {
                      if (forecastSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (forecastSnapshot.hasData) {
                        final forecast = forecastSnapshot.data!;

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final isLargeScreen = constraints.maxWidth > 600;

                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: isLargeScreen
                                  ? GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2.5,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                      itemCount: forecast.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _buildWeatherCard(
                                            context, forecast[index]);
                                      },
                                    )
                                  : ListView.builder(
                                      itemCount: forecast.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return _buildWeatherCard(
                                            context, forecast[index]);
                                      },
                                    ),
                            );
                          },
                        );
                      }

                      return Center(
                        child: Column(
                          children: [
                            const Text('Failed to retrieve forecast data.'),
                            Text(forecastSnapshot.error.toString()),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }

            return Center(
              child: Column(
                children: [
                  const Text('Failed to retrieve data.'),
                  Text(snapshot.error.toString()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context, Weather weather) {
    final weatherIcon = weather.weatherIcon!;
    final iconUrl =
        swWeather.fetchWeatherIconURL(weatherIconCode: weatherIcon, size: 2);
    final date = weather.date!;
    final temp = NumberFormat('#').format(weather.temperature!.celsius);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Adjust text sizes based on available width in constraints
        double titleFontSize = constraints.maxWidth < 400 ? 14 : 16;
        double dateFontSize = constraints.maxWidth < 400 ? 12 : 14;
        double tempFontSize = constraints.maxWidth < 400 ? 24 : 28;
        double mainFontSize = constraints.maxWidth < 400 ? 12 : 14;
        double iconScale = constraints.maxWidth < 400 ? 1.5 : 1.0;

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
          color: primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 4.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        swDt.getDayName(date),
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: titleFontSize,
                        ),
                      ),
                      Text(
                        swDt.getMonthAndDate(date),
                        style: TextStyle(fontSize: dateFontSize),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$temp°C',
                        style: TextStyle(
                          fontSize: tempFontSize,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        swDt.getTimeIn12HourFormat(date),
                        style: TextStyle(fontSize: dateFontSize),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(iconUrl, scale: iconScale),
                      Text(
                        weather.weatherMain!,
                        style: TextStyle(fontSize: mainFontSize),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
