import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/button/refresh_button.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  String locationName = '';
  double temperature = 0.0;
  String weatherCondition = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );

      String apiKey =
          '7694dea5580450ef02723bb4986150e2'; // Replace with your actual OpenWeatherMap API key
      String apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
      String units =
          'metric'; // 'metric' for Celsius, 'imperial' for Fahrenheit

      var response = await http.get(
        Uri.parse(
            '$apiUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=$units'),
      );

      if (response.statusCode == 200) {
        var weatherData = jsonDecode(response.body);
        setState(() {
          locationName = weatherData['name'];
          temperature = weatherData['main']['temp'];
          weatherCondition = weatherData['weather'][0]['main'];
        });
      } else {
        print('Failed to fetch weather data');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather App',
          style: GoogleFonts.getFont('Lato', fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('weather.png'),
              radius: 150,
            ),
            Text(
              'Location: $locationName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Temperature: ${temperature.toStringAsFixed(1)}°C',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Weather Condition: $weatherCondition',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            RefreshButton(),
          ],
        ),
      ),
    );
  }
}
