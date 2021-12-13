part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final WeatherModel _weather;

  WeatherModel get weather => _weather;

  WeatherIsLoaded(this._weather);
}

class WeatherIsNotLoaded extends WeatherState {}
