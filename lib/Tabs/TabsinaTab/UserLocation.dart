import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

export 'package:flutter_map/flutter_map.dart';
export 'package:flutter_map/src/core/bounds.dart';
export 'package:flutter_map/src/core/center_zoom.dart';
export 'package:flutter_map/src/map/map.dart';
import 'package:latlong/latlong.dart';

class UserLocation extends StatelessWidget {
  String integrationURL = 'https://api.mapbox.com/styles/v1/owlrepo/ckaje2uvf1swe1imh1s34979s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib3dscmVwbyIsImEiOiJja2FqYXV4Y3AwMWRvMnFsanR0ejg5M3lhIn0.wpynejbQSmO7B0UUi9P5ZQ';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlutterMap(
          options: MapOptions(center: LatLng(40.71, -74.40), minZoom: 15.0),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  integrationURL,
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
                  point: LatLng(12.8797, -121.7740),
                  builder: (context) => Container(
                    child: IconButton(
                      icon: Icon(Icons.location_on),
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
