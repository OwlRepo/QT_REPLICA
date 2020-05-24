import 'package:flutter/material.dart';

class UserLocationProvider with ChangeNotifier {
  double _latitude, _longtitude;

  double get latitude => _latitude;
  double get longtitude => _longtitude;

  set latitude(double value) {
    _latitude = value;
    notifyListeners();
  }

  set longtitude(double value) {
    _longtitude = value;
    notifyListeners();
  }
}
