import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui.dart';
import '/BLoC/bloc.dart';

TextEditingController cityController = TextEditingController();
String? lastCityName;

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
        return const Center(
          child: Text('Err'),
        );
      },
    );
  }
}