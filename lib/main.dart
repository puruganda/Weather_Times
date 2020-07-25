import 'package:weather_times/screens/city_screen.dart';
import 'package:weather_times/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() {
  runApp(WeatherTimes());
}

class WeatherTimes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Acme',
          brightness: Brightness.dark,
          dialogBackgroundColor: Colors.white,
        ),
        routes: {
          '/cityScreen': (context) => CityScreen(),
        },
        home: WelcomeScreen(),
      ),
      overlayColor: Colors.black54,
      overlayOpacity: 1.0,
      overlayWidget: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.tealAccent[200],
          ),
        ),
      ),
    );
  }
}
