import 'package:geolocator/geolocator.dart';

Future<Position> Get_Location() async {
  try {
    bool is_service_enabled = await Geolocator.isLocationServiceEnabled();

    if (!is_service_enabled) {
      return Future.error('Location Services are disabled');
    }

    LocationPermission location_permission =
    await Geolocator.checkPermission();

    if (location_permission == LocationPermission.denied) {
      location_permission = await Geolocator.requestPermission();
      if (location_permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }

    if (location_permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we can\'t access');
    }

    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  } catch (error) {
    rethrow;
  }
}