import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
        
          // appBar: AppBar(
          //   title: Text('Home Screen')
          // ),
          // body:Center(child: Text('Welcome to the Home Screen!'),),
            // Background
            body: Container(
                width: double.infinity,
                height: double.infinity,
            decoration: const BoxDecoration(
            gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
            Color(0xFF8D6E63), // Earthy Brown
            Color(0xFF4CAF50), // Green
            ],
            ),
        ),
        ),
        // Display Homepage Content
        /**Container(
            padding: const EdgeInsets.all(20),
        child: Column(
            children: [
                const Text(
                    "What will you discover?"
                    style: TextStyle(fontSize: 18, color: Colors.white)
                )
                const SizedBox(height: 20),
                /*
                ElevatedButton(
                    onPressed: null, // default for now
                    style: bac
                )*/
          ],z

            
        )**/);

    }
}