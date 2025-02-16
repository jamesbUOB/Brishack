import 'package:flutter/material.dart';
import 'customise.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key); // Added constructor

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
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
  // Introduction Section
  SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: const Text(
          "Bristol is alive with movement—foxes searching for food under the glow of streetlights, rats navigating the city's hidden tunnels, and humans shaping their world without realizing it. How do your choices change this delicate balance?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ),

  // Foxes Section
  SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🦊 Foxes in the City - Adaptive Survivors",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            factItem("Bristol's Foxes Are Becoming 'Street Smart'",
                "Urban foxes in Bristol have learned to navigate traffic patterns, waiting for quieter moments to cross roads safely—almost as if they understand pedestrian behavior!"),
            factItem("Bristol’s Foxes Rely on Late-Night Takeaways!",
                "Food waste from fast-food spots and student areas has influenced fox diets, making them more reliant on urban scraps rather than hunting natural prey."),
            factItem("Foxes change their diet based on human waste!",
                "Urban foxes eat up to 60% human food waste, affecting their long-term health and survival skills."),
          ],
        ),
      ),
    ),
  ),

  // Rats Section
  SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "🐀 Rats - The Hidden Navigators",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            factItem("Bristols Rats Are Getting Bolder",
                "With reduced natural predators, urban rats have become more fearless, even scavenging in well-lit areas where they once avoided humans."),
            factItem("Rats Play a Role in the City’s Waste System",
                "While often seen as pests, rats actually help break down organic waste, playing an unofficial role in Bristol’s waste cycle—though in excess, they become a problem."),
            factItem("Rats Are Learning from Humans!",
                "Studies show that urban rats in Bristol adapt to human routines, often raiding bins right after people throw out food as if they’ve learned the city’s waste collection schedules."),
          ],
        ),
      ),
    ),
  ),


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
                      label: const Text('Back to Home', style: TextStyle(color: Colors.white)),
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
  
                  
                  /**SliverToBoxAdapter(
              child: Center( // Wrap button in Center for better layout
                child: ElevatedButton(
                  onPressed: () {
                    socket.emit('message', 'start');
                  },

                  child: const Text('Start simulation'),
                ),
              ),
            ),**/

  }

  Widget factItem(String title, String description) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "🔹 $title",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    ),
  );
}

}
