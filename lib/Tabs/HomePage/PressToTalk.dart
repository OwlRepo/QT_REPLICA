import 'dart:async';
import 'dart:io' as io;
import 'package:file/local.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';

class PressToTalk extends StatefulWidget {
  @override
  _PressToTalkState createState() => _PressToTalkState();
  final LocalFileSystem localFileSystem;

  PressToTalk({localFileSystem})
      : this.localFileSystem = localFileSystem ?? LocalFileSystem();
}

class _PressToTalkState extends State<PressToTalk> {
  final memberList = [
    'Member 1',
    'Member 2',
    'Member 3',
    'Member 4',
    'Member 5',
    'Member 6'
  ];

  //All of this is for recording the audio when the mic button is onhold
  //NOTE: Always use the _init() fucntion after recording
  
  FlutterAudioRecorder _recorder;
  Recording _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  //Initialize Access for mic.
  _init() async {
    try {
      if (await FlutterAudioRecorder.hasPermissions) {
        String customPath = '/QTAudioRecording';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = await getExternalStorageDirectory();
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder = FlutterAudioRecorder(customPath,
            audioFormat: AudioFormat.WAV, sampleRate: 48000);

        await _recorder.initialized;
        // after initialization
        var current = await _recorder.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current.status;
          print(_currentStatus);
        });
      } else {
        Scaffold.of(context).showSnackBar(
            new SnackBar(content: new Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }
  //Start recording
  _start() async {
    try {
      await _recorder.start();
      var recording = await _recorder.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = const Duration(milliseconds: 50);
      new Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder.current(channel: 0);
        print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current.status;
        });
      });
    } catch (e) {
      print(e);
    }
  }
  //Stop recording
  _stop() async {
    var result = await _recorder.stop();
    print("Stop recording: ${result.path}");
    print("Stop recording: ${result.duration}");

    setState(() {
      _current = result;
      _currentStatus = _current.status;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _init();
    super.initState();
  }
  //END

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
                                msg: memberList[index] +
                                    " has been successfully selected",
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
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
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
                          trailing: FaIcon(
                            FontAwesomeIcons.list,
                            size: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: GestureDetector(
                    onLongPress: () async {
                      if (_currentStatus == RecordingStatus.Initialized) {
                        _start();
                        widgetHelper.micButtonAnimation = 'OnPressedStart';
                        widgetHelper.micButtonAnimation = 'OnPressedHold';
                      } else {
                        print('Not Initialized');
                      }
                    },
                    onLongPressUp: () async {
                      if (_currentStatus == RecordingStatus.Recording) {
                        widgetHelper.micButtonAnimation = 'OnReleaseStop';
                        _stop();
                      }
                      Future.delayed(Duration(seconds: 1), () {
                        _init();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 65.0),
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
