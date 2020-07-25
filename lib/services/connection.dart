import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:weather_times/utilities/constants.dart';
import 'package:system_settings/system_settings.dart';
import 'package:flutter/services.dart';

class Connection {
  final BuildContext context;

  Connection({this.context});

  Connectivity connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> checkConnectivityChanged() {
    return connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      }
    });
  }

  Future checkInternetConnection() async {
    ConnectivityResult connectivityResult;
    connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: Text(
                'Network not available',
                style: kDialogTitleTextStyle,
              ),
              content: Text(
                'Please retry after you verify your internet connection.',
                style: kDialogContentTextStyle,
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'Exit',
                    style: kDialogButtonTextStyle,
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    SystemSettings.wireless();
                  },
                  child: Text(
                    'Settings',
                    style: kDialogButtonTextStyle,
                  ),
                ),
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        },
      );
    }
  }
}
