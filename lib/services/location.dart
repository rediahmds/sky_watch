import 'package:geolocator/geolocator.dart';

class SkyWatchGeolocator {
  Future<Position> getCurrentCoord() async {
    // check location service
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      return Future.error('Location service are disabled');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // request permission if denied
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // handle when permission permanently denied
        return Future.error(
            'Location permission denied forever. SkyWatch cannot request permission.');
      }

      if (permission == LocationPermission.denied) {
        // handle permission denied AGAIN
        return Future.error('Location permission are denied again');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    return position;
  }
}
