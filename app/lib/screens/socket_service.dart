import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketService {
  late IO.Socket socket;
  String connectionStatus = 'Disconnected';

  // Initialize and connect the socket.
  void connect() {
    socket = IO.io('http://127.0.0.1:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.on('connect', (_) {
      connectionStatus = 'Connected';
      print('Connected: ${socket.id}');
    });

    socket.on('disconnect', (_) {
      connectionStatus = 'Disconnected';
      print('Disconnected');
    });

    socket.connect();
  }

  // Disconnect the socket.
  void disconnect() {
    socket.disconnect();
  }
}