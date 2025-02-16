import 'package:flutter/material.dart';
import 'home.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key); // Added constructor

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
             SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: Padding(
              
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  height: 200,))),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
             SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  height: 200,))),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
             SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  height: 200,))),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
             SliverToBoxAdapter(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  height: 200,))),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                  SliverToBoxAdapter(
              child: Center( // Wrap button in Center for better layout
                child: ElevatedButton(
                  onPressed: () {
                    socket.emit('message', 'start');
                  },

                  child: const Text('Start simulation'),
                ),
              ),
            ),
            
          ],
        ),
              ),
             );
          
  }
}
