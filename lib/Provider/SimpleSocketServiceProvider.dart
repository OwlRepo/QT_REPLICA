import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SimpleSocketServiceProvider {
    static String serverAddress = '';
  // Dart server
  static void initializeServer() async {
    var io = new Server();
    var nsp = io.of('/some');
    nsp.on('connection', (client) {
      print('connection /some');
      client.on('msg', (data) {
        print('data from /some => $data');
        client.emit('fromServer', "ok 2");
      });
    });
    io.on('connection', (Socket client) {
      print('connection default namespace');
      client.on('msg', (data) {
        print('data from default => $data');
        client.emit('fromServer', "Your are now successfully connected");
      });
    });
    io.listen(3000);
  }

  static void initializeClient() {
    IO.Socket socket = IO.io(serverAddress, <String, dynamic>{
      'transports': '',
      'autoConnect': false,
      'query': '1',
      'reconnection': true,
      'reconnectionDelay': 1000,
      'timeout': 10000,
    });
    socket.on('connect', (_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }
}
