import 'package:flutter_bloc/flutter_bloc.dart';
import '/BLoC/weather_bloc.dart';

import '../ui.dart';
import '/models/weather_model.dart';

class ShowWidget extends StatelessWidget {
  const ShowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    final WeatherModel weather = (weatherBloc.state as WeatherIsLoaded).weather;
    return Column(
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
        ElevatedButton(
          onPressed: (){weatherBloc.add(ResetWeather());},
          child: const Text('return'),
        ),
      ],
    );
  }
}
