import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sky_watch/screens/forecast.dart';
import 'package:sky_watch/screens/settings.dart';
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

  static const _primaryColorCode = 0xffffe142; // Yellow
  static const _primaryColor = Color(_primaryColorCode);
  static const _secondaryColorCode = 0xffffed8f; // Whitey-yellow
  static const _secondaryColor = Color(_secondaryColorCode);

  static const _appDescription = 'Weather information at your fingertips';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'SkyWatch',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          backgroundColor: _primaryColor,
          leading: Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedMenu02,
                    color: Colors.black87,
                    size: 35.0,
                  )),
            );
          })),
      backgroundColor: _primaryColor,
      drawer: Drawer(
        backgroundColor: _secondaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: _primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SkyWatch',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  ),
                  Text(_appDescription),
                ],
              ),
            ),
            ListTile(
              leading: const HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar03,
                color: Colors.black,
                size: 24.0,
              ),
              title: const Text('Forecasts'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Forecast(
                    primaryColor: _primaryColor,
                    position: _position,
                  );
                }));
              },
            ),
            ListTile(
              leading: const HugeIcon(
                icon: HugeIcons.strokeRoundedSettings02,
                color: Colors.black,
                size: 24.0,
              ),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Settings(primaryColor: _primaryColor);
                }));
              },
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ValueListenableBuilder<String?>(
                valueListenable: openWeatherApiKeyNotifier,
                builder: (context, value, child) {
                  return FutureBuilder<Position>(
                    future: _position,
                    builder: (BuildContext context,
                        AsyncSnapshot<Position> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Show loading indicator
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
                  );
                }),
          ),
        ),
      ),
    );
  }
}
