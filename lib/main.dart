import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather_bloc.dart';
import 'package:weather_app/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());
TextEditingController cityController = TextEditingController();
String? lastCityName;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => WeatherBloc(),
          child: const SearchPage(),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  Future<void> tryGetLastCityName(WeatherBloc weatherBloc) async {
    lastCityName = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('lastCityName'));
    if (lastCityName != null) weatherBloc.add(FetchWeather(lastCityName!));
  }

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (lastCityName == null) tryGetLastCityName(weatherBloc);
        if (state is WeatherIsNotSearched) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Search Weather'),
                const Text('Instanly'),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: cityController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white70)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    hintText: 'City Name',
                    hintStyle: const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                  onPressed: () {
                    weatherBloc.add(FetchWeather(cityController.text));
                  },
                  child: const Text('Search'),
                )
              ],
            ),
          );
        } else if (state is WeatherIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WeatherIsLoaded) {
          return ShowWeather(weather: state.weather);
        }
        return const Text('Err');
      },
    );
  }
}

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
