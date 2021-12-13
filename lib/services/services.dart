import 'dart:developer';

import 'package:geocode/geocode.dart';
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

  return '${_locationData.latitude} ${_locationData.longitude}';
}


Future<String> getCityName(double latitude, double longitude, int call) async {
  // free api throw exception
  // "throttled to no more that 1 request per second for all free port users combined"
  if (call > 5) return '';
  try {
    return await GeoCode()
        .reverseGeocoding(latitude: latitude, longitude: longitude)
        .then((address) => address.city ?? '');
  } catch (e) {
    log('method "getCityName" call № $call');
    log(e.toString());
    return getCityName(latitude, longitude, ++call);
  }
}
