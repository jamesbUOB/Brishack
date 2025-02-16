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
        child:  CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Image.asset('assets/images/1739708480986lwnjvf57-remove-background.com.png',
                                    width: 200,
                                    height: 200,
                                  ),
            ),),
            SliverToBoxAdapter(
              child: Center( 
                child: Padding(
                  padding: EdgeInsets.all(20),
                child: Text(
                  'Hackitat',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            )),
            
            SliverToBoxAdapter(
              
            )
                  ],
                ),
              ),
    );
  }
}
