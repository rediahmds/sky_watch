import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sky_watch/services/instances.dart';
import 'package:sky_watch/widgets/current_date_day.dart';
import 'package:sky_watch/widgets/current_location.dart';
import 'package:sky_watch/widgets/current_weather_info.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: FutureBuilder<Position>(
                future: _position, // Use FutureBuilder to wait for location
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
                    final position =
                        snapshot.data!; // Extract the Position data

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const CurrentDateAndDay(),
                        CurrentLocation(
                          latitude: position.latitude,
                          longitude: position.longitude,
                        ),
                        CurrentWeatherInfo(
                          latitude: position.latitude,
                          longitude: position.longitude,
                        ),
                      ],
                    );
                  }

                  return const Text('Failed to retrieve location data.');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
