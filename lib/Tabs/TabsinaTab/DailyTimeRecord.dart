import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quicktalk_replica/SpecialWidgets/Map.dart';
import 'package:flutter/material.dart';
import 'package:geolocation/geolocation.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/Provider/UserLocationProvider.dart';
import 'package:latlong/latlong.dart';

class DailyTimeRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> timeDateLoc = [
      'Time : Display Current Time here',
      'Date: Display Current Date here',
      'Location: Display Current Location here',
    ];

    List timeDateLocIcons = [
      FontAwesomeIcons.solidClock,
      FontAwesomeIcons.solidCalendar,
      FontAwesomeIcons.mapMarkerAlt,
    ];

    String integrationURL =
        'https://api.mapbox.com/styles/v1/owlrepo/ckaje2uvf1swe1imh1s34979s/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib3dscmVwbyIsImEiOiJja2FqYXV4Y3AwMWRvMnFsanR0ejg5M3lhIn0.wpynejbQSmO7B0UUi9P5ZQ';

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

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: FutureBuilder(
            future: setUpUserLocation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: FlutterMap(
                    options: MapOptions(
                        center: LatLng(userLocationProvider.latitude,
                            userLocationProvider.longtitude),
                        minZoom: 5.0,
                        maxZoom: 18.0,
                        zoom: 16.0,
                        interactive: false),
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
                            width: 35.0,
                            height: 35.0,
                            point: LatLng(userLocationProvider.latitude,
                                userLocationProvider.longtitude),
                            builder: (context) => Container(
                              child: IconButton(
                                icon: FaIcon(FontAwesomeIcons.mapMarkerAlt,
                                    color: Colors.red),
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
                );
              } else {
                return Container(
                  child: Center(
                    child: Text('Loading'),
                  ),
                );
              }
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.only(top: 30.0),
            color: Color.fromRGBO(238, 231, 239, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: timeDateLoc.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: ListTile(
                                leading: FaIcon(
                                  timeDateLocIcons[index],
                                  color: Color.fromRGBO(46, 24, 89, 1),
                                ),
                                title: Text(
                                  timeDateLoc[index],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding:
                        EdgeInsets.only(bottom: 220.0, left: 20.0, right: 20.0),
                    child: RaisedButton(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Color.fromRGBO(46, 24, 89, 1),
                      onPressed: () {},
                      child: Text(
                        'Time In',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
