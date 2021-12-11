import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/weather_model.dart';

class WeatherRepository {
  WeatherModel? weather;

  WeatherRepository(String city);

  Future<WeatherModel?> getWeatherByCityName(String city) async {
    String url = "https://geocoding-api.open-meteo.com/v1/search?name=$city";

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map<String, dynamic> data = json.decode(response.body);
    double latitude = data['results'][0]['latitude'];
    double longitude = data['results'][0]['longitude'];
    String argLocation = 'latitude=$latitude&longitude=$longitude';
    weather = await getWeatherByLocation(argLocation);

    return weather;
  }

  Future<WeatherModel?> getWeatherByLocation(String argLocation) async {
    String url = "https://api.open-meteo.com/v1/forecast?"
        "$argLocation&daily=temperature_2m_max,temperature_2m_min"
        "&current_weather=true&windspeed_unit=ms&timezone=Asia%2FOmsk";

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    Map<String, dynamic> data = json.decode(response.body);
    String tempMin = '${data['daily']['temperature_2m_min'][0]} '
        '${data['daily_units']['temperature_2m_min']}';
    String tempMax = '${data['daily']['temperature_2m_max'][0]} '
        '${data['daily_units']['temperature_2m_max']}';
    String scale = tempMin.split(' ').last;
    String temp = '${data['current_weather']['temperature']} $scale';
    weather = WeatherModel(temp, tempMin, tempMax);
    return weather;
  }
}
