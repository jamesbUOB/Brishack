import 'package:flutter/material.dart';
import 'introduction.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
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
        
        // Display Homepage Content
          child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "What will you discover?",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add your onPressed code here!
                  Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>  Introduction()),
                  );
                },
                child: const Text("Explore Birstol's EcoSystem"),

            
        ),
          ],))),
          );

    }
}