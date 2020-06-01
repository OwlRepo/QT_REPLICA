import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'Pages/HomePage.dart';
import 'Pages/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation fadeInAnimation;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    fadeInAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 5),
      () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      },
    );
    _controller.forward();

    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    return FadeTransition(
      opacity: fadeInAnimation,
      child: Scaffold(
        body: ColorFiltered(
          colorFilter:
              ColorFilter.mode(Color.fromRGBO(46, 24, 89, 1), BlendMode.color),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/Images/splash_bg.png'),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: FadeTransition(
                opacity: fadeInAnimation,
                child: Image.asset(
                  'assets/Images/splash_logo.png',
                  fit: BoxFit.contain,
                  height: 200.0,
                  width: 200.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
