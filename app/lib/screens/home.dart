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
        child:  CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Image.asset('assets/images/1739708480986lwnjvf57-remove-background.com.png',
                                    width: 500,
                                    height: 500,
                                  ),
            ),),

            const SliverToBoxAdapter(
              child: Center( 
                child: Padding(
                  padding: EdgeInsets.all(20),
                child: Text(
                  'Introuction paragraph',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            )),
            

                  ],
                ),
              ),
    );
  }
}
