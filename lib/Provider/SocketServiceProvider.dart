import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:udp/udp.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:eventify/eventify.dart' as Emitter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io/socket_io.dart';

class SocketServiceProvider {
  static String serverAddress = '';
  static bool isConnected = false;
  static Socket socket = null;
  static SharedPreferences sharedPreferences;

  static int sampleRate = 16000;
  static int frameSize = 512;
  static int numChannels = 1;

  static bool audioPlaying = false, turnOnGreen = false;
  static int turnOffgreen = 0;
  static ChewieAudio audioPlayer;

  static bool recorderOn = false;

  //CONNECT TO SERVER
  static void initializeServerSocket() {
    String namespace = 'QTRoom';
    var io = new Server();
    var nsp = io.of('/QTRoom');
    nsp.on(
      'connection',
      (client) {
        print('connected to /QTRoom');
        client.on(
          'msg',
          (data) {
            print('data from /QTRoom => $data');
            client.emit('fromServer', "Status: SUCCESS");
          },
        );
      },
    );
    io.on('connection', (client) {
      print('connection default namespace');
      client.on('msg', (data) {
        print('data from default => $data');
        client.emit('fromServer', "ok");
      });
    });
    io.listen(3000);
  }
  //CONNECT TO SOCKET FOR CLIENT
  static void initializeClientSocket() async {
    List events = [
      'connect',
      'connect_error',
      'connect_timeout',
      'connecting',
      'disconnect',
      'error',
      'reconnect',
      'reconnect_attempt',
      'reconnect_failed',
      'reconnect_error',
      'reconnecting',
      'ping',
      'pong'
    ];

    try {
      IO.Socket socket = IO.io(serverAddress, <String, dynamic>{
        'transports': '',
        'autoConnect': false,
        'query': '1',
        'reconnection': true,
        'reconnectionDelay': 1000,
        'timeout': 10000,
      });
      if (!socket.connected) {
        socket.on('connect', (data) {
          Emitter.EventEmitter emitter = Emitter.EventEmitter();
          Emitter.Listener subscriber =
              emitter.on('timer', null, (ev, context) {
            if (!isConnected) {
              isConnected = true;
              print('Connected');
            }
          });
        });
        socket.on('disconnect', (data) {
          Emitter.EventEmitter emitter = Emitter.EventEmitter();
          Emitter.Listener subscriber =
              emitter.on('timer', null, (ev, context) {
            isConnected = false;
          });
        });
        socket.on('connect_error', (data) {
          Emitter.EventEmitter emitter = Emitter.EventEmitter();
          Emitter.Listener subscriber =
              emitter.on('timer', null, (ev, context) {
            isConnected = false;
          });
        });
        socket.on('connect_timeout', (data) {
          Emitter.EventEmitter emitter = Emitter.EventEmitter();
          Emitter.Listener subscriber =
              emitter.on('timer', null, (ev, context) {
            isConnected = false;
          });
        });
        socket.on('voice_message', (data) {
          Emitter.EventEmitter emitter = Emitter.EventEmitter();
          Emitter.Listener subscriber =
              emitter.on('timer', null, (ev, context) async {
            if (!audioPlaying) {
              audioPlaying = true;
              audioPlayer = ChewieAudio(
                controller: ChewieAudioController(
                  autoPlay: true,
                  autoInitialize: true,
                ),
              );
            }
            Timer.periodic(Duration(milliseconds: 600000), (v) {
              try {
                if (turnOffgreen == 2) {
                  audioPlaying = false;
                  turnOnGreen = false;
                }
                turnOffgreen++;
              } catch (e) {
                print(e);
              }
            });
          });
        });
        socket.connect();
      }
    } catch (e) {
      print(e);
    }
    //INITIALIZE
    var receiver = await UDP.bind(
      Endpoint.loopback(
        port: Port(6666),
      ),
    );
    //RECIEVER DATA
    receiver.listen(
      (dataGram) {
        var packet = String.fromCharCodes(dataGram.data, dataGram.data.length);
        stdout.write(packet);
        Uint8List bytesArray = utf8.encode(packet);
        var stringData = String.fromCharCodes(bytesArray, 0, bytesArray.length);
        print(stringData);
      },
      timeout: Duration(
        seconds: 20,
      ),
    );
    //DISPOSE
    receiver.close();
  }

//SENDER
  static void sendMessage({@required String room, @required String message}) {
    socket.emit(room, message);
  }
}
