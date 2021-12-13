import '../ui.dart';
import '/models/weather_model.dart';

class ShowWeather extends StatelessWidget {
  final WeatherModel weather;

  const ShowWeather({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
      child: Column(
        children: [
          Text(weather.city),
          const SizedBox(
            height: 10,
          ),
          Text(weather.temp),
          const Text('Temperature'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(weather.tempMin),
                  const Text('Min Temperature'),
                ],
              ),
              Column(
                children: [
                  Text(weather.tempMax),
                  const Text('Max Temperature'),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container()
        ],
      ),
    );
  }
}
