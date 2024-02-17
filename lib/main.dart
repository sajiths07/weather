import 'package:flutter/material.dart';

import 'model/home_page.dart';

void main() {
  runApp(MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',

      home: WeatherHomePage(),

    );
  }
}