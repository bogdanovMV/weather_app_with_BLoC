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
  log(_locationData.toString());

  return '${_locationData.latitude} ${_locationData.longitude}';
}

String? getLocationUrl(String? location) {
  if (location == null) return null;
  String _lat = location.split(' ').first;
  String _lon = location.split(' ').last;

  return 'latitude=$_lat&longitude=$_lon';
}

Future<String> getCityName(double latitude, double longitude) async {
  Address address = await GeoCode().reverseGeocoding(latitude: latitude, longitude: longitude);
  log(address.toString());

  return address.city ?? '';
}
