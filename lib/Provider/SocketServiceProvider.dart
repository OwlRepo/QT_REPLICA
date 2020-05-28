import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io/socket_io.dart';

class SocketServiceProvider {
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

  static void initializeClientSocket() {
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

    IO.Socket socket = IO.io('uri');
    socket.on(
      'connect',
      (_) {
        print('connected');
        socket.emit('fromClient', 'Status: SUCCESS');
      },
    );

    while (!socket.connected) {
      for (int process = 0; process <= events.length; process++) {
        socket.on(events[process], (data) => null);
      }
      socket.on('voice_message', (data) {});
      socket.connect();
    }
  }
}
