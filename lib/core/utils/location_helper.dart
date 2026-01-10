import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/errors/app_exception.dart';

class LocationHelper {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw AppException("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw AppException("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw AppException(
        "Location permission permanently denied. Please enable it from settings.",
      );
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
  }
}
