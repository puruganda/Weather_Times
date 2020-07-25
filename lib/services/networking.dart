import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PositionData {
  final String apiUrl;
  PositionData({@required this.apiUrl});

  Future<dynamic> getPositionWeather() async {
    http.Response response = await http.get(apiUrl);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('status ${response.statusCode} : ${response.reasonPhrase}');
    }
  }
}
