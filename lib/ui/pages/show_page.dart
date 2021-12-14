import '../ui.dart';
import '/models/weather_model.dart';

class ShowPage extends StatelessWidget {
  final WeatherModel weather;

  const ShowPage({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(weather.city),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  width: 50,
                  child: Image.asset('assets/images/${weather.state}.png'))
            ],
          ),
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
