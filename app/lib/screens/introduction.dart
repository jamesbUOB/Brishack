import 'package:flutter/material.dart';
import 'home.dart'; 
import 'package:socket_io_client/socket_io_client.dart' as IO;


class Introduction extends StatefulWidget {

  @override
  _IntroductionState createState() => _IntroductionState();

}
class _IntroductionState extends State<Introduction> {
  late IO.Socket socket;
  String connectionStatus = 'Disconnected';
  String message = '';

  @override
  void initState() {
    super.initState();
    // Configure and connect the socket.
    socket = IO.io('http://127.0.0.1:5000', <String, dynamic>{
      'transports': ['websocket'], // use WebSocket transport
      'autoConnect': false,
    });

    // Set up event listeners.
    socket.on('connect', (_) {
      setState(() {
        connectionStatus = 'Connected';
      });
      print('Connected: ${socket.id}');
    });

    socket.on('update', (data) {
      setState(() {
        message = data.toString();
      });
      print('Update event: $data');
    });

    socket.on('disconnect', (_) {
      setState(() {
        connectionStatus = 'Disconnected';
      });
      print('Disconnected');
    });

    // Connect the socket.
    socket.connect();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //    appBar: AppBar(
        // title: Text('Introduction Screen'),
      // ),
       body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              //Color(0xFF4CAF50), // Green

              Color(0xFF8D6E63), 
              Color(0xFF4CAF50),
              // Earthy Brown
            ],
          ),
        ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
          socket.emit('message', 'start');
          },
          child: const Text('Start simulation'),
        ),
      ),),);
    
  }
}