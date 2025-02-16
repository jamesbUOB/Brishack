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
 List<bool> choices = <bool>[ false,false,false ];
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
             SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [ 
          const Text(
          "Land Pollution",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Switch(value: choices[0], onChanged:(bool value) {
        setState(() {
        choices[0] = value; // Update the state when toggled
        });
        },)
        ],),
        ),),),
          SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [ 
          const Text(
          "Air Pollution",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Switch(value: choices[1], onChanged:(bool value) {
        setState(() {
        choices[1] = value; // Update the state when toggled
        });
        },)
        ],),
        ),),),
          SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [ 
          const Text(
          "Urbanisation",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Switch(value: choices[2], onChanged:(bool value) {
        setState(() {
        choices[2] = value; // Update the state when toggled
        });
        },)
        ],),
        ),),),
          SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(child:
        Column(
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
              Text('Message from server:'),
              Text(message, style: TextStyle(fontSize: 20)),
              ElevatedButton(
                onPressed: () {
                  // Send a test message to the server.
                  socket.emit('message', 'start');
                },
                child: Text('Start simulation'),
              ),
            ],
          ),
        ),
        ),),),
 SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      label: const Text('Back', style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 13, 87, 15)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CustomisePage()),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 13, 87, 15)),
                      ),
                      child: Row(
                        children: const [
                          Text('Next', style: TextStyle(color: Colors.white)),
                          SizedBox(width: 5), // Add some space between the text and the icon
                          Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                           ),
                  ],
                ),
                   ),
            ),
               ],
        ),
            ),
    );

}
}