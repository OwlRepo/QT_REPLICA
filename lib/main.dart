import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/PreLoadFlare.dart';
import 'package:quicktalk_replica/Provider/UserLocationProvider.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';
import 'dart:async';

import 'package:quicktalk_replica/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FlareCache.doesPrune = false;
  PreLoadFlare();
  requestPermissions();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WidgetHelper()),
        ChangeNotifierProvider(create: (context) => UserLocationProvider()),
      ],
      child: MyApp(),
    ),
  );
}

//THIS IF FOR GETTING THE PERMISSIONS NEEDED
Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
    Permission.storage,
    Permission.camera,
    Permission.microphone,
    Permission.sensors
  ].request();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarColor(Color.fromRGBO(46, 24, 89, 1));
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
