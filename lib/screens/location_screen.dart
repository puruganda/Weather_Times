import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_times/services/weather.dart';
import 'package:weather_times/utilities/constants.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LocationScreen extends StatefulWidget {
  final dynamic weatherLocation;
  LocationScreen({@required this.weatherLocation});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  String weatherDescription;
  String cityName;
  int temperature;
  String weatherIcon;
  String weatherMessage;

  void updateData(var weatherData) {
    setState(() {
      if (weatherData == null) {
        return;
      }
      cityName = weatherData['name'];
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherDescription = weatherData['weather'][0]['main'];
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
      weatherMessage = weatherModel.getWeatherMessage(temperature);
    });
  }

  @override
  void initState() {
    super.initState();
    updateData(widget.weatherLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          context.showLoaderOverlay();
                          var weatherData =
                              await weatherModel.getLocationWeather(context);
                          context.hideLoaderOverlay();
                          updateData(weatherData);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.my_location,
                            size: 35.0,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var weatherData =
                              await Navigator.pushNamed(context, '/cityScreen');
                          updateData(weatherData);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.location_city,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 30.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              cityName,
                              style: kCityNameTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '$temperature°',
                              style: kWeatherTextStyle,
                            ),
                            Text(
                              weatherIcon,
                              style: kWeatherIconTextStyle,
                            ),
                          ],
                        ),
                        Text(
                          weatherDescription,
                          style: kWeatherDescriptionTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                  style: kWeatherMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
