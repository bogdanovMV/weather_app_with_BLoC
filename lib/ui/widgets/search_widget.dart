import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/BLoC/weather_bloc.dart';

import '../ui.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({Key? key}) : super(key: key);
  WeatherBloc? weatherBloc;

  @override
  Widget build(BuildContext context) {
    weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Search Weather',
            textAlign: TextAlign.center,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            controller: cityController,
            decoration: InputDecoration(
              prefixIcon:
                  IconButton(onPressed: fetch, icon: const Icon(Icons.search)),
              hintText: 'City Name',
            ),
          ),
          ElevatedButton(
            onPressed: fetch,
            child: const Text('Search'),
          )
        ],
      ),
    );
  }

  void fetch() {
    weatherBloc?.add(FetchWeather(cityController.text));
  }
}
