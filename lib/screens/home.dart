import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sky_watch/services/instances.dart';
import 'package:sky_watch/widgets/current_date_day.dart';
import 'package:sky_watch/widgets/current_location.dart';
import 'package:sky_watch/widgets/current_weather_info.dart';
import 'package:sky_watch/widgets/five_days_forecast.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Position> _position;

  @override
  void initState() {
    super.initState();
    _position = swGeolocator
        .getCurrentCoord(); // Fetch location when widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffe142),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: FutureBuilder<Position>(
              future: _position,
              builder:
                  (BuildContext context, AsyncSnapshot<Position> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show loading indicator
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error: ${snapshot.error}')); // Show error message
                }

                if (snapshot.hasData) {
                  final position = snapshot.data!; // Extract the Position data

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CurrentLocation(
                        latitude: position.latitude,
                        longitude: position.longitude,
                      ),
                      const CurrentDateAndDay(),
                      CurrentWeatherInfo(
                        latitude: position.latitude,
                        longitude: position.longitude,
                      ),
                      FiveDaysForecast(
                          latitude: position.latitude,
                          longitude: position.longitude)
                    ],
                  );
                }

                return const Text('Failed to retrieve location data.');
              },
            ),
          ),
        ),
      ),
    );
  }
}
