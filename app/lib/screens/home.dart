import 'package:flutter/material.dart';
import 'introduction.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

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
              Color(0xFF8D6E63), // Earthy Brown
              Color(0xFF4CAF50), // Green
            ],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Logo at the Top
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
            /**Text(
              'Your Bristol Your Future', // Your text
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 31, 61, 42),
                 shadows: [
                  Shadow(
                offset: Offset(3, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.5),
              ),
                ],
              ),
            ),**/
          DefaultTextStyle(
  style: TextStyle(
    fontSize: 70,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 31, 61, 42),
                 shadows: [
                  Shadow(
                offset: Offset(3, 3),
                blurRadius: 5,
                color: Colors.black.withOpacity(0.5),
              ),
                ],
  ),
  child: AnimatedTextKit(
    animatedTexts: [
      WavyAnimatedText('Your Bristol Your Future'),
      //WavyAnimatedText('Your Future'),
    ],
    isRepeatingAnimation: true,
    /**onTap: () {
      print("Tap Event");
    },**/
  ),)
        ],
        ),
      ),
    ),
    const SliverToBoxAdapter(
              child: SizedBox(
                height: 50, // Add space between the container and the button
              ),
            ),
    const SliverToBoxAdapter(child: SizedBox(height: 100)), // Add space between the image and the container
             SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Image
                      Container(
                        width: 300,
                        height: 400,
                        padding: EdgeInsets.only(right: 20),
                        child: Image.asset(
                          'assets/images/suspensionbridge.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Right: Introduction Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome to Bristol’s Living City:",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Where nature and urban life collide!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 15),

                            // Fun Fact
                            Text(
                              "🌿 Did you know? More than 90% of residents live within 300 meters of a green space, making it one of the best cities for urban biodiversity.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 15),

                            // Exploration Points
                            Text(
                              "Step into Bristol’s spaces and explore:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "• How foxes and rats survive in Bristol’s urban landscape\n"
                              "• The impact of pollution, food availability, and climate shifts\n"
                              "• The delicate balance between wildlife, urban expansion, and biodiversity.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 15),

                            // Call to Action
                            Text(
                              "🌱 Your journey starts here!",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Space before button
            const SliverToBoxAdapter(
              child: SizedBox(height: 50),
            ),

            // Button at the Bottom
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
            ),
          ],
        ),
      ),
    );
  }
}
