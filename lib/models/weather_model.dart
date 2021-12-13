import 'dart:developer';

class WeatherModel {
  final String city;
  final String temp;
  final String tempMin;
  final String tempMax;
  final String state;

  WeatherModel(
      this.city, this.temp, this.tempMin, this.tempMax, int _weatherCode)
      : state = _weatherCodeToState(_weatherCode);

  static String _weatherCodeToState(int weatherCode) {
    if ([0, 1].contains(weatherCode)) {
      return 'c';
    } else if (weatherCode == 2) {
      return 'lc';
    } else if ([3, 45, 48].contains(weatherCode)) {
      return 'hc';
    } else if ([51, 61, 80].contains(weatherCode)) {
      return 's';
    } else if ([53, 56, 63, 66, 81].contains(weatherCode)) {
      return 'lr';
    } else if ([55, 57, 65, 67, 82].contains(weatherCode)) {
      return 'hr';
    } else if ([71, 73, 75].contains(weatherCode)) {
      return 'sn';
    } else if (weatherCode == 95) {
      return 't';
    } else if (weatherCode == 96) {
      return 'h';
    } else if (weatherCode == 99) {
      return 'sl';
    }
    log('weatherCode: $weatherCode');
    return '';
  }
}
