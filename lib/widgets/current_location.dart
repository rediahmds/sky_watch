import 'package:flutter/material.dart';
import 'package:sky_watch/services/instances.dart'; // Your weather service

class CurrentLocation extends StatelessWidget {
  final double latitude;
  final double longitude;

  const CurrentLocation(
      {super.key, required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: swWeather.fetchCurrentCityNameByCoord(
          latitude: latitude, longitude: longitude),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
              'Fetching city information...'); // Show loading while waiting
        }

        if (snapshot.hasError) {
          return const Text('Error while retrieving city information.');
        }

        if (snapshot.hasData) {
          return Text(
              snapshot.data ?? 'Unknown Location'); // Display the city name
        }

        return const Text('Failed to retrieve city information.');
      },
    );
  }
}
