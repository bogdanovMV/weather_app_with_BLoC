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
        primarySwatch: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.yellow.shade50,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.lightGreen.shade200, width: 4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.green.shade800, width: 4),
          ),
          hintStyle: TextStyle(color: Colors.yellow.shade50),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.yellow.shade200,
            fontSize: 28.0,
          ),
          bodyText2: const TextStyle(
            color: Colors.green,
            fontSize: 48.0,
            fontFamily: 'Creepster',
            shadows: [Shadow(color: Colors.yellowAccent, offset: Offset(0, 0), blurRadius: 20)]
          ),
          button: TextStyle(
            foreground: Paint()..color=Colors.yellow.shade100,
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
