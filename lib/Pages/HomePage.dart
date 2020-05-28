import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';
import 'package:quicktalk_replica/Tabs/HomePage/Groups.dart';
import 'package:quicktalk_replica/Tabs/HomePage/MyAccount.dart';
import 'package:quicktalk_replica/Tabs/HomePage/PressToTalk.dart';
import 'package:quicktalk_replica/Tabs/HomePage/TabsinaTab.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widgetHelper = Provider.of<WidgetHelper>(context);
    final selectedTab = [
      Groups(),
      PressToTalk(),
      TabsinaTab(),
      MyAccount(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          selectedTab[widgetHelper.currentIndexBottomNav],
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: BottomNavigationBar(
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                currentIndex: widgetHelper.currentIndexBottomNav,
                onTap: (index) async {
                  widgetHelper.currentIndex = index;
                  widgetHelper.micButtonAnimation = 'Normal';
                },
                items: [
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.users,
                      size: 20.0,
                    ),
                    title: Text(''),
                    backgroundColor: Color.fromRGBO(46, 24, 89, 1),
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.microphone,
                      size: 20.0,
                    ),
                    title: Text(''),
                    backgroundColor: Color.fromRGBO(46, 24, 89, 1),
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.briefcase,
                      size: 20.0,
                    ),
                    title: Text(''),
                    backgroundColor: Color.fromRGBO(46, 24, 89, 1),
                  ),
                  BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.userAlt,
                      size: 20.0,
                    ),
                    title: Text(''),
                    backgroundColor: Color.fromRGBO(46, 24, 89, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
