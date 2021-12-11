import 'package:location/location.dart';
import 'package:flutter/foundation.dart';

Future<String?> getGPSCoordinates() async {
  Location location = Location();
  if (!kIsWeb) {
    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
  }

  LocationData _locationData = await location.getLocation();
  return 'latitude=${_locationData.latitude}&longitude=${_locationData.longitude}';
}
