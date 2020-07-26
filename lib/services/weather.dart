import 'package:weather_times/services/location.dart';
import 'package:weather_times/services/networking.dart';
import 'package:weather_times/utilities/constants.dart';
import 'package:weather_times/privateKeys.dart';
import 'package:flutter/cupertino.dart';

// Note: To run this project please provide your own apiKey as the apiKey provided is private and cannot be accessed.
// - refer https://openweathermap.org/ to get an apiKey

class WeatherModel {
  Future<dynamic> getLocationWeather(BuildContext context) async {
    var location = await Position().getPosition(context);
    if (location == null) {
      return;
    }
    PositionData positionData = PositionData(
        apiUrl:
            '$kOpenWeatherMapApi?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    //provide apiKey
    var weatherData = await positionData.getPositionWeather();
    return weatherData;
  }

  Future<dynamic> getCityWeather(String city) async {
    PositionData positionData = PositionData(
        apiUrl: '$kOpenWeatherMapApi?q=$city&appid=$apiKey&units=metric');
    //provide apiKey
    var weatherData = await positionData.getPositionWeather();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩️';
    } else if (condition < 400) {
      return '🌧️';
    } else if (condition < 600) {
      return '🌦️';
    } else if (condition < 700) {
      return '❄️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getWeatherMessage(int temperature) {
    if (temperature > 25) {
      return 'It\'s 🍦 time';
    } else if (temperature > 20) {
      return 'Time for shorts and 👕';
    } else if (temperature < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
