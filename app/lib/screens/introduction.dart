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
      appBar: AppBar(
        title: Text('Introduction Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text('Back to Home Screen'),
        ),
      ),
    );
  }
}