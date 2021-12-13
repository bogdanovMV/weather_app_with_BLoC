import 'package:flutter/material.dart';
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
      home: Scaffold(
        body: BlocProvider(
          create: (BuildContext context) => WeatherBloc(),
          child: const SearchPage(),
        ),
      ),
    );
  }
}
