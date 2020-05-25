import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/videoListItems.dart';
import 'package:video_player/video_player.dart';

import '../../Provider/WidgetHelper.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  List<String> idLevelDays = [
    'Account ID: 123321',
    'Call Level: 99',
    'March 08, 2020 - March 04,2021 (287 Days Remaining)',
  ];
  String daysRemaining = '287 Days Remaining';

  List idLevelDaysIcons = [
    FontAwesomeIcons.idCardAlt,
    FontAwesomeIcons.phone,
    FontAwesomeIcons.calendar,
  ];
  @override
  Widget build(BuildContext context) {
    final widgetHelper = Provider.of<WidgetHelper>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: [
              ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  videoListItems(
                    videoPlayerController: VideoPlayerController.asset(
                        'assets/Videos/MyAccountVideoBanner.mp4'),
                    looping: true,
                  ),
                ],
              ),
              Text(
                'VERSA',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Color.fromRGBO(238, 231, 239, 1),
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: [
                Positioned(
                  top: -43.0,
                  child: Container(
                    height: 80.0,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07),
                    child: Card(
                      elevation: 10.0,
                      shadowColor: Color.fromRGBO(46, 24, 89, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'ROM\n',
                                style: TextStyle(
                                  color: Color.fromRGBO(46, 24, 89, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              TextSpan(
                                text: 'Romeo Angeles Jr',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.07,
                        right: MediaQuery.of(context).size.width * 0.07),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 225.0,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 20.0,
                            shadowColor: Color.fromRGBO(46, 24, 89, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: ListView.builder(
                              itemCount: idLevelDays.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 25.0,
                                  ),
                                  leading: FaIcon(
                                    idLevelDaysIcons[index],
                                    color: Color.fromRGBO(46, 24, 89, 1),
                                  ),
                                  title: Text(
                                    idLevelDays[index],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .065,
                          child: RaisedButton(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.black87,
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: 15.0),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .065,
                          child: RaisedButton(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Color.fromRGBO(46, 24, 89, 1),
                            onPressed: () {},
                          ),
                        ),
                      ],
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
