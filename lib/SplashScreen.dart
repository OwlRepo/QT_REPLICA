import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Pages/HomePage.dart';
import 'Pages/HomePage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return Scaffold(
      body: ColorFiltered(
        colorFilter: ColorFilter.mode(Color.fromRGBO(46, 24, 89, 1), BlendMode.color),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Images/splash_bg.png'),
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
