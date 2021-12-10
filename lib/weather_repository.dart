import 'dart:convert';
import 'dart:io';
import 'package:weather_app/weather_model.dart';

class WeatherRepository {
  WeatherModel? weather;

  WeatherRepository(String city);

  Future<WeatherModel?> getWeather(String city) async {
    String url = "https://api.open-meteo.com/v1/forecast?"
        "latitude=55&longitude=73&daily=temperature_2m_max,temperature_2m_min"
        "&current_weather=true&windspeed_unit=ms&timezone=Asia%2FOmsk";

    HttpClient client = HttpClient();
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    if (response.statusCode != 200) {
      throw Exception();
    }
    String reply = await response.transform(utf8.decoder).join();
    Map<String, dynamic> data = json.decode(reply);
    client.close();
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
