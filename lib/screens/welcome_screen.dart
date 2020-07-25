import 'dart:async';
import 'package:weather_times/services/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_times/screens/location_screen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:weather_times/utilities/constants.dart';
import 'package:weather_times/services/connection.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather(context);
    if (weatherData == null) {
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          weatherLocation: weatherData,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () async {
        Connection connection = Connection(context: context);
        connectivitySubscription = connection.checkConnectivityChanged();
        await connection.checkInternetConnection();
        getLocationData();
      },
    );
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                'images/WeatherTimes_logo.png',
                color: Colors.white,
              ),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.blueAccent.shade100),
              ),
              Text(
                'Weather Times',
                style: kWeatherTimesTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
