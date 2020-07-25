import 'package:location/location.dart';
import 'package:flutter/material.dart';

class Position {
  void _checkCurrentRoute(BuildContext context) {
    String currentRoute = ModalRoute.of(context).settings.name;
    if (currentRoute == '/') {
      Navigator.pushReplacementNamed(context, '/cityScreen');
    }
  }

  Future getPosition(BuildContext context) async {
    Location location = Location();
    PermissionStatus permissionStatus;
    bool serviceEnabled;
    LocationData locationData;

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        _checkCurrentRoute(context);
        return;
      }
    }
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        _checkCurrentRoute(context);
        return;
      }
    }
    locationData = await location.getLocation();
    return locationData;
  }
}
