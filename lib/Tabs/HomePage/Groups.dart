import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Groups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groupList = ['Group 1', 'Group 2'];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/Images/group_banner.png'),fit: BoxFit.cover),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 30.0,
                  ),
                  child: Text(
                    'Groups',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: Container(
            color: Color.fromRGBO(238, 231, 239, 1),
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: ListView.builder(
              
              itemCount: groupList.length,
              itemBuilder: (context, index) {
                return Card(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5.0,
                  child: ListTile(
                    onTap:(){print(groupList[index]);},
                    title: Text(groupList[index]),
                    leading: FaIcon(FontAwesomeIcons.users),
                    
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
