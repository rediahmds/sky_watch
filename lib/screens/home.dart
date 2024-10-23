import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hugeicons/hugeicons.dart';
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

  static const _colorCode = 0xffffe142;
  static const _backgroundColor = Color(_colorCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'SkyWatch',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          backgroundColor: _backgroundColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: IconButton(
                onPressed: () {
                  print('Bars pressed');
                },
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedMenu02,
                  color: Colors.black87,
                  size: 35.0,
                )),
          )),
      backgroundColor: _backgroundColor,
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
