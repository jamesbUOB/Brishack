/**import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create a Socket.IO client instance.
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
    return MaterialApp(
      title: 'Ecosystem simulation',
      home: Scaffold(
        appBar: AppBar(title: Text('Ecosystem Simulation')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Connection Status: $connectionStatus'),
              SizedBox(height: 20),
              Text('Message from server:'),
              Text(message, style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Send a test message to the server.
                  socket.emit('start', 'parameters');
                },
                child: Text('Start simulation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}**/

import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}