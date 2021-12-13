import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../services/services.dart';
import '/models/weather_model.dart';
import '/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

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
              .timeout(const Duration(seconds: 1));
        } else {
          String? location = await getGPSCoordinates();
          String? argLocationUrl = getLocationUrl(location);
          if (argLocationUrl != null) {
            double _lat = double.parse(location!.split(' ').first);
            double _lon = double.parse(location.split(' ').last);
            String _city = await getCityName(_lat, _lon, 0)
                .timeout(const Duration(seconds: 1), onTimeout: () => '');
            weatherModel = await weatherRepository
                .getWeatherByLocation(argLocationUrl, _city)
                .timeout(const Duration(seconds: 1));
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

String? getLocationUrl(String? location) {
  if (location == null) return null;
  String _lat = location.split(' ').first;
  String _lon = location.split(' ').last;
  return 'latitude=$_lat&longitude=$_lon';
}
