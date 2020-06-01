import 'dart:async';
import 'package:file/local.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quicktalk_replica/Provider/WidgetHelper.dart';
import 'dart:typed_data';
import 'package:sound_stream/sound_stream.dart';

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

  RecorderStream _recorder = RecorderStream();
  PlayerStream _player = PlayerStream();

  List<Uint8List> _micChunks = [];
  bool _isRecording;
  bool _isPlaying;

  StreamSubscription _recorderStatus;
  StreamSubscription _playerStatus;
  StreamSubscription _audioStream;

  @override
  void initState() {
    super.initState();
    initPlugin();
  }

  @override
  void dispose() {
    _recorderStatus?.cancel();
    _playerStatus?.cancel();
    _audioStream?.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    _recorderStatus = _recorder.status.listen((status) {
      if (mounted)
        setState(() {
          _isRecording = status == SoundStreamStatus.Playing;
        });
    });

    _audioStream = _recorder.audioStream.listen((data) {
      _micChunks.add(data);
    });

    _playerStatus = _player.status.listen((status) {
      if (mounted)
        setState(() {
          _isPlaying = status == SoundStreamStatus.Playing;
        });
    });

    await Future.wait([
      _recorder.initialize(),
      _player.initialize(),
    ]);
  }

  void _playAudio() async {
    await _player.start();

    if (_micChunks.isNotEmpty) {
      for (var chunk in _micChunks) {
        await _player.writeChunk(chunk);
      }
      _micChunks.clear();
    }

    if (_micChunks.isEmpty) {
      _player.stop();
      _isPlaying = false;
    }
  }

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
          flex: 2,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
                Color.fromRGBO(46, 24, 89, 1), BlendMode.color),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(46, 24, 89, 1),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/Images/group_banner.png',
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 30.0,
                      left: 30.0,
                    ),
                    child: Text(
                      'Press To Talk',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 15,
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
                      if (_isPlaying == false) {
                        _isRecording = true;
                        await _recorder.start();
                        widgetHelper.micButtonAnimation = 'OnPressedHold';
                      } else {
                        Fluttertoast.showToast(
                            msg: "Someone is still speaking!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                    onLongPressUp: () async {
                      if (_isRecording == true) {
                        await _recorder.stop();
                        _playAudio();
                        widgetHelper.micButtonAnimation = 'OnReleaseStop';
                      }
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
