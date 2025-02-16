import 'package:flutter/material.dart';
import 'home.dart'; // Import the home.dart file

class Introduction extends StatefulWidget {
  @override
  _IntroductionState createState() => _IntroductionState();

}
class _IntroductionState extends State<Introduction> {
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            
          },
          child: Text('Back to Home Screen'),
        ),
      ),),);
    
  }
}