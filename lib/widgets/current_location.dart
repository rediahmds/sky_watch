import 'package:flutter/material.dart';
import 'package:sky_watch/services/instances.dart'; // Your weather service

class CurrentLocation extends StatelessWidget {
  final double latitude;
  final double longitude;
  final TextStyle style;

  const CurrentLocation(
      {super.key,
      required this.latitude,
      required this.longitude,
      this.style = const TextStyle(fontSize: 28.0)});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: swWeather.fetchCurrentCityNameByCoord(
          latitude: latitude, longitude: longitude),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text(
            'Fetching city information...',
            style: style,
          ); // Show loading while waiting
        }

        if (snapshot.hasError) {
          return Text('Error while retrieving city information.', style: style);
        }

        if (snapshot.hasData) {
          return Center(
            child: Text(
              snapshot.data ?? 'Unknown Location',
              style: style,
            ),
          ); // Display the city name
        }

        return Text(
          'Failed to retrieve city information.',
          style: style,
        );
      },
    );
  }
}
