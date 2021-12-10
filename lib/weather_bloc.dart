import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/weather_model.dart';
import 'package:weather_app/weather_repository.dart';

@immutable
abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String _city;

  FetchWeather(this._city);
}

class ResetWeather extends WeatherEvent {}

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

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherIsNotSearched()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherIsLoading());
      try {
        WeatherModel? weatherModel =
            await weatherRepository.getWeather(event._city);
        emit(WeatherIsLoaded(weatherModel!));
      } catch (_) {
        emit(WeatherIsNotLoaded());
      }
    });
    on<ResetWeather>((event, emit) async {
      emit(WeatherIsNotSearched());
    });
  }
}
