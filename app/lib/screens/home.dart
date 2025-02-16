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
        child: Column(
          //mainAxisSize: MainAxisSize.min, // Minimize vertical space
          children: [
            Image.asset(
              'assets/images/1739708480986lwnjvf57-remove-background.com.png',
              width: 500,
              height: 500,
            ),
            const Text(
              'Your Bristol; Your Future', // Your text
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
    const SliverToBoxAdapter(child: SizedBox(height: 100)), // Add space between the image and the container
             SliverToBoxAdapter(
              child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust the padding as needed
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 600,
      width: double.infinity, // Ensure the container takes the available width within the padding
    ),
  ),
             ),
             const SliverToBoxAdapter(
              child: Center(
              // child: SizedBox(
              //   height: 50, // Add space between the container and the button
              // ),
                child: Padding(
                  padding: EdgeInsets.only(top: 10), // Adjust the padding as needed
                  child: Text(
                    "What will you discover?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                ),
            ),),),),
             const SliverToBoxAdapter(
              child: SizedBox(height: 20),),
         SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                        backgroundColor: const Color.fromARGB(255, 15, 114, 18),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                    ),
                    ),
                onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Introduction()),
                      );
                    },
                    child: const Text(
                      'Begin Your Exploration!',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                           ),
               ),
                  ),
                ),
              ),],
            ),
          
        ),
      );
    
  }
}