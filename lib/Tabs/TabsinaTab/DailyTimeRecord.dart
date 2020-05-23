import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DailyTimeRecord extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(238, 231, 239, 1),
      child: Center(
        child: FaIcon(
          FontAwesomeIcons.userClock,
          size: 100.0,
          color: Color.fromRGBO(46, 24, 89, 1),
        ),
      ),
    );
  }
}
