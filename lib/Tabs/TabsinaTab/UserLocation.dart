import 'dart:async';
import 'package:quicktalk_replica/SpecialWidgets/Map.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
export 'package:flutter_map/flutter_map.dart';
export 'package:flutter_map/src/core/bounds.dart';
export 'package:flutter_map/src/core/center_zoom.dart';
export 'package:flutter_map/src/map/map.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/Provider/UserLocationProvider.dart';

class UserLocation extends StatelessWidget {
  String integrationURL =
      'https://api.mapbox.com/styles/v1/owlrepo/ckaje2uvf1swe1imh1s34979s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib3dscmVwbyIsImEiOiJja2FqYXV4Y3AwMWRvMnFsanR0ejg5M3lhIn0.wpynejbQSmO7B0UUi9P5ZQ';
  @override
  Widget build(BuildContext context) {
    final userLocationProvider = Provider.of<UserLocationProvider>(context);

    //Setting up the user current location in the map
    Future<StreamSubscription<LocationResult>> setUpUserLocation() async {
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
        return subscription;
    }
    //END

    return FutureBuilder(
      future: setUpUserLocation(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Map();
        } else {
          return Container(
            child: Center(
              child: Text('Loading'),
            ),
          );
        }
      },
    );
  }
}
