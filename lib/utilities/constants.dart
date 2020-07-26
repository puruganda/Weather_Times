import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kOpenWeatherMapApi = 'https://api.openweathermap.org/data/2.5/weather';

const kWeatherTimesTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'MeriendaOne',
);

const kCityNameTextStyle = TextStyle(
  fontSize: 30.0,
);

const kWeatherTextStyle = TextStyle(
  fontSize: 100.0,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w300,
);

const kWeatherIconTextStyle = TextStyle(
  fontSize: 100.0,
);

const kWeatherDescriptionTextStyle = TextStyle(
  fontSize: 28.0,
);

const kWeatherMessageTextStyle = TextStyle(
  fontSize: 60.0,
);

const kTextFieldTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 20.0,
);

const kTextFieldInputDecoration = InputDecoration(
  prefixIcon: Icon(
    Icons.location_city,
    size: 30.0,
    color: Colors.black,
  ),
  hintText: 'Search City',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
    borderSide: BorderSide.none,
  ),
);

const kGetWeatherTextStyle = TextStyle(
  fontSize: 25.0,
);

const kDialogButtonTextStyle = TextStyle(
  fontSize: 16.0,
  fontFamily: 'Raleway',
  color: Colors.blue,
);

const kDialogTitleTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Raleway',
);

const kDialogContentTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Raleway',
  fontSize: 17.0,
);

const kBoxDecoration = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('images/weatherTimes_Bg.jpg'),
    fit: BoxFit.cover,
  ),
);
