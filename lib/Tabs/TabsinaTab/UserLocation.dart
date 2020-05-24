import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocation/geolocation.dart';
export 'package:flutter_map/flutter_map.dart';
export 'package:flutter_map/src/core/bounds.dart';
export 'package:flutter_map/src/core/center_zoom.dart';
export 'package:flutter_map/src/map/map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/Provider/UserLocationProvider.dart';

class UserLocation extends StatelessWidget {
  String integrationURL =
      'https://api.mapbox.com/styles/v1/owlrepo/ckaje2uvf1swe1imh1s34979s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib3dscmVwbyIsImEiOiJja2FqYXV4Y3AwMWRvMnFsanR0ejg5M3lhIn0.wpynejbQSmO7B0UUi9P5ZQ';
  @override
  Widget build(BuildContext context) {
    final userLocationProvider = Provider.of<UserLocationProvider>(context);



    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlutterMap(

          options: MapOptions(center: LatLng(userLocationProvider.latitude,userLocationProvider.longtitude), minZoom: 5.0,maxZoom: 18.0,zoom: 18.0),
          layers: [
            TileLayerOptions(
              urlTemplate: integrationURL,
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1Ijoib3dscmVwbyIsImEiOiJja2FqYXV4Y3AwMWRvMnFsanR0ejg5M3lhIn0.wpynejbQSmO7B0UUi9P5ZQ',
                'id': 'mapbox.mapbox-streets-v8',
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 45.0,
                  height: 45.0,
                  point: LatLng(userLocationProvider.latitude,userLocationProvider.longtitude),
                  builder: (context) => Container(
                    child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.mapMarkerAlt,color:Colors.red),
                      iconSize: 45.0,
                      onPressed: () {
                        print('Marker Tapped');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
