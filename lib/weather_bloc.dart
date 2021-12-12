import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/services.dart';
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

  WeatherBloc()
      : weatherRepository = WeatherRepository(),
        super(WeatherIsNotSearched()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherIsLoading());
      WeatherModel? weatherModel;
      try {
        if (event._city.isNotEmpty) {
          weatherModel = await weatherRepository
              .getWeatherByCityName(event._city)
              .timeout(const Duration(seconds: 3));
        } else {
          String? location = await getGPSCoordinates();
          String? argLocationUrl = getLocationUrl(location);
          if (argLocationUrl != null) {
            double _lat = double.parse(location!.split(' ').first);
            double _lon = double.parse(location.split(' ').last);
            String _city = await getCityName(_lat, _lon);
            weatherModel = await weatherRepository
                .getWeatherByLocation(argLocationUrl, _city)
                .timeout(const Duration(seconds: 3));
          }
        }
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
