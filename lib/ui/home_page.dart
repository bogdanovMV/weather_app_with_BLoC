import 'package:shared_preferences/shared_preferences.dart';
import 'ui.dart';
import '/BLoC/bloc.dart';

TextEditingController cityController = TextEditingController();
String? lastCityName;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Future<void> tryGetLastCityName(WeatherBloc weatherBloc) async {
    lastCityName = await SharedPreferences.getInstance()
        .then((prefs) => prefs.getString('lastCityName'));
    if (lastCityName != null) weatherBloc.add(FetchWeather(lastCityName!));
  }

  @override
  Widget build(BuildContext context) {
    final WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          controller: ScrollController(
            initialScrollOffset: 950,
          ),
          scrollDirection: Axis.horizontal,
          child: Image.asset(
            'assets/images/background.jpeg',
            fit: BoxFit.fill,
          ),
        ),
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (lastCityName == null) tryGetLastCityName(weatherBloc);
            if (state is WeatherIsNotSearched) {
              return SearchWidget();
            } else if (state is WeatherIsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherIsLoaded) {
              return const ShowWidget();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'An error has occurred.\nCheck the network connection',
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: () {
                    weatherBloc.add(ResetWeather());
                  },
                  child: const Text('return'),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
