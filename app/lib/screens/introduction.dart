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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        const Text(
          "🌍 Bristol’s Urban Wildlife",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        // Image
        /*ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/images/bristol_wildlife.jpg', // Add a relevant image
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),*/
        const SizedBox(height: 15),

        // Introduction Text
        const Text(
          "Bristol is alive with movement - foxes searching for food under the glow of streetlights, "
          "rats navigating the city's hidden tunnels, and humans shaping their world without realising it.\n\n"
          "How do your choices change this delicate balance?",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ],
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
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)], // Adds subtle shadow for depth
      ),
      padding: const EdgeInsets.all(20),

      child: Row( // Row to align text on left & image on right
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Centered Title
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.pets, size: 24, color: Colors.orange), // Fox Icon
                      const SizedBox(width: 10),
                      const Text(
                        "Foxes in the City - Adaptive Survivors",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Facts List
                factItem("🚦 Bristol's Foxes Are Becoming 'Street Smart'",
                    "Urban foxes have learned to navigate traffic, waiting for quieter moments to cross roads."),
                factItem("🍟 Bristol’s Foxes Rely on Late-Night Takeaways!",
                    "Food waste from student areas has influenced their diet, making them rely more on urban scraps."),
                factItem("🗑️ Foxes change their diet based on human waste!",
                    "Urban foxes eat up to 60% human food waste, affecting their long-term health and survival skills."),
              ],
            ),
          ),

          // Image (Fox Urban)
          SizedBox(width: 20), // Space between text & image
          ClipRRect(
            borderRadius: BorderRadius.circular(15), // Rounded edges for image
            child: Image.asset(
              'assets/images/fox.jpg',
              width: 300, 
              height: 300,
              fit: BoxFit.cover, // Ensure the image fills the space well
            ),
          ),
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
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)], // Subtle shadow for depth
      ),
      padding: const EdgeInsets.all(20),
      
      child: Row( // Aligns image on the left & text on the right
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image (Rat Urban)
          ClipRRect(
            borderRadius: BorderRadius.circular(15), // Rounded edges for image
            child: Image.asset(
              'assets/images/rat.webp',
              width: 300, // Adjust size as needed
              height: 300,
              fit: BoxFit.cover, // Ensures image fills the space properly
            ),
          ),
          const SizedBox(width: 20), // Space between image & text

          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Centered Title
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.directions_walk, size: 24, color: Colors.brown), // Rat Icon
                      const SizedBox(width: 10),
                      const Text(
                        "Rats - The Hidden Navigators",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Facts List
                factItem("🐀 Bristol’s Rats Are Getting Bolder",
                    "With reduced natural predators, urban rats have become more fearless, scavenging even in well-lit areas."),
                factItem("🗑️ Rats Play a Role in the City’s Waste System",
                    "While often seen as pests, they help break down organic waste, playing an unofficial role in Bristol’s ecosystem."),
                factItem("🕒 Rats Are Learning from Humans!",
                    "Studies show urban rats in Bristol adapt to human routines, raiding bins right after waste collection."),
              ],
            ),
          ),
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
                      label: const Text('Back', style: TextStyle(color: Colors.white)),
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
],),
                    ),
                  ],
                ),
              ),
            ),
          ],
      )));

        
                  
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
