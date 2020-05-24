import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:quicktalk_replica/Pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/PreLoadFlare.dart';
import 'package:quicktalk_replica/Provider/UserLocationProvider.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';
import 'dart:async';

import 'package:quicktalk_replica/Tabs/TabsinaTab/UserLocation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    //THIS PART IS FOR PREPARING THE USERS LOCATION SO THAT WHEN HE VIEWS THE MAP THE LATLONG IS ALREADY LOADED
    final userLocationProvider = Provider.of<UserLocationProvider>(context);//Accessing the provider to be able to set the value of LatLong later
    Future<void> getPermission() async {
      //Cheking if permissions are granted on both OS
      final GeolocationResult result =
          await Geolocation.requestLocationPermission(
              permission: const LocationPermission(
                  android: LocationPermissionAndroid.fine,
                  ios: LocationPermissionIOS.always),
              openSettingsIfDenied: true);
      //END
      //If the permissions are granted. We will get the current Location and its LatLong and send that LatLong value to UserLocationProvider
      if (result.isSuccessful) {
        StreamSubscription<LocationResult> subscription =
            Geolocation.currentLocation(accuracy: LocationAccuracy.best).listen(
          (result) {
            if (result.isSuccessful) {
              double latitude = result.location.latitude;
              double longtitude = result.location.longitude;
              userLocationProvider.latitude = latitude;
              userLocationProvider.longtitude = longtitude;
            }
          },
        );
      }
      //END
    }
      //Calling the function in the beginning of the app to preload it
      getPermission();
      //END
    //END
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
