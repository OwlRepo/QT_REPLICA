import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';

class PressToTalk extends StatelessWidget {
  final memberList = [
    'Member 1',
    'Member 2',
    'Member 3',
    'Member 4',
    'Member 5',
    'Member 6'
  ];

  @override
  Widget build(BuildContext context) {
    final widgetHelper = Provider.of<WidgetHelper>(context);
    void createAlertDialog() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)),
              content: SingleChildScrollView(
                child: Container(
                  height: 300.0,
                  width: 150.0,
                  padding: EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: memberList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5.0,
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.solidUserCircle),
                          title: Text(memberList[index]),
                          onTap: () {
                            widgetHelper.selectedMember = memberList[index];
                            Fluttertoast.showToast(
                                msg: memberList[index] + " has been successfully selected",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Color.fromRGBO(46, 24, 89, 1),
                                textColor: Colors.white,
                                fontSize: 16.0);
                                Navigator.of(context).pop();
                          },
                          
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Color.fromRGBO(46, 24, 89, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 30.0,
                  ),
                  child: Text(
                    'Press To Talk',
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.0),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.only(left:20.0,right:20.0),
                    child: GestureDetector(
                      onTap: () {
                        createAlertDialog();
                      },
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          leading: FaIcon(FontAwesomeIcons.solidUserCircle),
                          title: Text(widgetHelper.selectedMember),
                          trailing: FaIcon(FontAwesomeIcons.list,size: 15.0,),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: GestureDetector(
                    onLongPress: () {
                      widgetHelper.micButtonAnimation = 'OnPressedStart';
                      widgetHelper.micButtonAnimation = 'OnPressedHold';
                      print('PRESSING');
                    },
                    onLongPressUp: () {
                      widgetHelper.micButtonAnimation = 'OnReleaseStop';
                      print('NOT ANYMORE');
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom:65.0),
                      child: FlareActor(
                        'assets/Animations/MicButtonSend.flr',
                        alignment: Alignment.center,
                        animation: widgetHelper.micButtonAnimation,
                        fit: BoxFit.contain,
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
