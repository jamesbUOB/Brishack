import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CustomisePage extends StatefulWidget {
  const CustomisePage({super.key});

  @override
  State<CustomisePage> createState() => _CustomisePageState();
}

class _CustomisePageState extends State<CustomisePage> {
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
    const List<String> choices = <String>[
      'Low',
      'Medium',
      'High',
    ];
    return Scaffold(
       body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8D6E63), // Earthy Brown
              Color(0xFF4CAF50), // Green
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [


            ]
          ],
        ))
        );
        
        /**Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Customise your ecosystem simulation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )
              ),
              Text('Connection Status: $connectionStatus'),
              SizedBox(height: 20),
              Text('Message from server:'),
              Text(message, style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Send a test message to the server.
                  socket.emit('message', 'start');
                },
                child: Text('Start simulation'),
              ),
            ],
          ),
    ),*/

}
}