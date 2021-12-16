import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/ui.dart';
import '/BLoC/weather_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.lightGreen.shade200, width: 4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.lightGreen.shade800, width: 4),
          ),
          hintStyle: const TextStyle(color: Colors.white54),
          labelStyle: const TextStyle(color: Colors.white)
        ),
        textTheme: TextTheme(
          bodyText1: const TextStyle(
            color: Colors.white70,
            fontSize: 28.0,
          ),
          bodyText2: const TextStyle(
            color: Colors.lightGreen,
            fontSize: 48.0,
            fontFamily: 'Creepster',
          ),
          button: TextStyle(
            foreground: Paint()..color=Colors.white70,
            fontSize: 36.0,
            fontFamily: 'Creepster',
          ),
        ),
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => WeatherBloc(),
          child: const HomePage(),
        ),
      ),
    );
  }
}
