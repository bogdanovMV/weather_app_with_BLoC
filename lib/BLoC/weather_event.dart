part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String _city;
  FetchWeather(this._city);
}

class ResetWeather extends WeatherEvent {}
