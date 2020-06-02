import 'dart:io';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:quicktalk_replica/Models/UsersModel.dart';

class SimpleSocketServiceProvider {
  static String _serverAddress =
      Platform.isIOS ? 'http://localhost' : 'http://10.0.0.2';

  static const int SERVER_PORT = 6000;
  static String _connectURL = '$_serverAddress:$SERVER_PORT';

  // Events
  static const String ON_MESSAGE_RECEIVED = 'receive_message';
  static const String SUB_EVENT_MESSAGE_SENT = 'message_sent_to_user';
  static const String IS_USER_CONNECTED_EVENT = 'is_user_connected';
  static const String IS_USER_ONLINE_EVENT = 'check_online';
  static const String SUB_EVENT_MESSAGE_FROM_SERVER = 'message_from_server';

  // Status
  static const int STATUS_MESSAGE_NOT_SENT = 10001;
  static const int STATUS_MESSAGE_SENT = 10002;
  static const int STATUS_MESSAGE_DELIVERED = 10003;
  static const int STATUS_MESSAGE_READ = 10004;

  //Type of connection

  static const String PEER_TO_PEER = 'peer_to_peer';
  static const String ONE_TO_MANY = 'one_to_many';

  UsersModel _fromUser;

  SocketIO _socket;
  SocketIOManager _manager;

  initSocket(UsersModel fromUser) async {
    this._fromUser = fromUser;
    print('Connecting ${fromUser.name}');
    await init();
  }

  init() async {
    _manager = SocketIOManager();
    _socket = await _manager.createInstance(socketOptions());
  }

  socketOptions() {
    final Map<String, dynamic> userMap = {
      'from': _fromUser.id.toString(),
    };
    return SocketOptions(
      _connectURL,
      enableLogging: true,
      transports: [Transports.WEB_SOCKET],
      query: userMap,
    );
  }

  //Connection checking

  setOnConnectionListener(Function onConnect) {
    _socket.onConnect((data) {
      onConnect(data);
    });
  }

  setOnConnectionErrorTimeOutListener(Function onConnectionTimeout) {
    _socket.onConnectTimeout((data) {
      onConnectionTimeout(data);
    });
  }

  setOnConnectionErrorListener(Function onConnectionError) {
    _socket.onConnectError((data) {
      onConnectionError(data);
    });
  }

  setOnErrorListener(Function onError) {
    _socket.onError((data) {
      onError(data);
    });
  }

  setOnDisconnectListener(Function onDisconnectListener){
    _socket.onDisconnect((data) { 
      onDisconnectListener(data);
    });
  }

  closeConnection(){
    if(null != _socket)
    {
      print('Closing connection');
      _manager.clearInstance(_socket);
    }
  }
}
