import 'package:weather_times/screens/location_screen.dart';
import 'package:weather_times/services/weather.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:weather_times/utilities/constants.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  WeatherModel weatherModel = WeatherModel();
  String city;

  void checkCanPop(var weatherData) {
    bool checkScreen = Navigator.canPop(context);
    if (checkScreen) {
      Navigator.pop(context, weatherData);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(weatherLocation: weatherData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: kBoxDecoration,
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () async {
                    context.showLoaderOverlay();
                    var weatherData =
                        await weatherModel.getLocationWeather(context);
                    context.hideLoaderOverlay();
                    if (weatherData != null) {
                      checkCanPop(weatherData);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.my_location,
                      size: 35.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 30.0, top: 20.0, left: 20.0, right: 20.0),
                child: TextField(
                  onChanged: (String value) {
                    city = value;
                  },
                  style: kTextFieldTextStyle,
                  decoration: kTextFieldInputDecoration,
                ),
              ),
              FlatButton(
                onPressed: () async {
                  if (city != '' && city != null) {
                    context.showLoaderOverlay();
                    var weatherData = await weatherModel.getCityWeather(city);
                    context.hideLoaderOverlay();
                    if (weatherData == null) {
                      Alert(
                        context: context,
                        title: 'No such City found!',
                        type: AlertType.info,
                        buttons: [
                          DialogButton(
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                        style: AlertStyle(
                          isCloseButton: false,
                        ),
                      ).show();
                      return;
                    }
                    checkCanPop(weatherData);
                  }
                },
                padding: EdgeInsets.all(10.0),
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                child: Text(
                  'Get Weather',
                  style: kGetWeatherTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
