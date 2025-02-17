import 'package:app/screens/reflection.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CustomisePage extends StatefulWidget {
  const CustomisePage({super.key});

  @override
  State<CustomisePage> createState() => _CustomisePageState();
}

class _CustomisePageState extends State<CustomisePage> {
  // socket based code
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
        // printing this will give you a long list of data once the simulation ends
        // simulation length is set to 60 seconds
        //print(message);
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
 // **Title & Introduction**
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "🌍 Shape Bristol’s Urban Wild: Your Choice Matter",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Adjust the conditions of the city and discover how it might affect its wild inhabitants. Will you create a thriving environment, or will unexpected challenges arise?",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),


        // **Land Pollution Toggle (Vertical Layout)**
  SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15), // Smaller rounded corners
  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)], // Softer shadow
),
padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), // Less padding
child: Column(
  mainAxisSize: MainAxisSize.min, // Makes the box only as tall as needed
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Icon(Icons.delete_outline, size: 28, color: Colors.grey), // Slightly smaller icon
    const SizedBox(height: 8), // Reduced spacing
    const Text(
      "Land Pollution",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 5), // Reduced spacing
    const Text(
      "Increase or decrease waste levels.",
      style: TextStyle(fontSize: 13, color: Colors.black87),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 10), 
        Switch(value: choices[0], onChanged:(bool value) {
        setState(() {
        choices[0] = value; // Update the state when toggled
        });
        },)
        ],),
        ),),),


        // **Air Pollution Toggle (Vertical Layout)**
  SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15), // Slightly smaller corners
  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)], // Softer shadow
),
padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), // Less padding
child: Column(
  mainAxisSize: MainAxisSize.min, // Makes the box only as tall as needed
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Icon(Icons.air, size: 28, color: Colors.blueGrey), // Slightly smaller icon
    const SizedBox(height: 8), // Reduced spacing
    const Text(
      "Air Pollution",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 5), // Reduced spacing
    const Text(
      "Increase or decrease pollution levels.",
      style: TextStyle(fontSize: 13, color: Colors.black87),
      textAlign: TextAlign.center,
    ),
        Switch(value: choices[1], onChanged:(bool value) {
        setState(() {
        choices[1] = value; // Update the state when toggled
        });
        },)
        ],),
        ),),),

    // **Urbanisation Toggle (Vertical Layout)**
  SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15), // Consistent with other boxes
  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 3)], // Softer shadow
),
padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), // Less padding
child: Column(
  mainAxisSize: MainAxisSize.min, // Keeps the box only as tall as needed
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Icon(Icons.location_city, size: 28, color: Colors.green), // Slightly smaller icon
    const SizedBox(height: 8), // Reduced spacing
    const Text(
      "Urbanisation",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 5), // Reduced spacing
    const Text(
      "Increase or decrease buildings and roads.",
      style: TextStyle(fontSize: 13, color: Colors.black87),
      textAlign: TextAlign.center,
    ),
    const SizedBox(height: 10),

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
        height: 90,
        padding: const EdgeInsets.all(20),
        child: Center(child:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      backgroundColor: const Color.fromARGB(255, 15, 114, 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                onPressed: () {
                  // Send the parameters to the server
                  var sent_data = {"waste": choices[0],
                  "mist": choices[1], "urban": choices[2]};

                  socket.emit('start', sent_data);
                },
                  child: const Text(
                      '🚀 See Your Impact!',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
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
                          MaterialPageRoute(builder: (context) => ReflectionsPage()),
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