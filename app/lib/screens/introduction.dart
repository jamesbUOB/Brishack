import 'package:flutter/material.dart';
import 'customise.dart';

class Introduction extends StatefulWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  int _currentFoxIndex = 0;
  int _currentRatIndex = 0;
  final PageController _foxController = PageController();
  final PageController _ratController = PageController();

  final List<Map<String, String>> foxFacts = [
    {
      "title": "🚦 Foxes Know When to Cross!",
      "description": "Urban foxes in Bristol wait for quieter moments to cross roads—almost as if they understand pedestrian behavior!"
    },
    {
      "title": "🍟 Foxes Love Late-Night Takeaways!",
      "description": "Fast-food waste from student areas has changed their diet, making them rely on human scraps."
    },
    {
      "title": "🗑️ Foxes Eat What We Throw Away",
      "description": "Studies show urban foxes eat up to 60% human food waste, which affects their survival skills."
    },
  ];

  final List<Map<String, String>> ratFacts = [
    {
      "title": "🐀 Bristol’s Bold Rats",
      "description": "With fewer natural predators, rats are becoming more fearless, even scavenging in well-lit areas."
    },
    {
      "title": "🗑️ Rats Are Nature’s Clean-Up Crew",
      "description": "Often seen as pests, they actually help break down organic waste, playing an important role in the city’s ecosystem."
    },
    {
      "title": "🕒 Rats Follow Your Routine!",
      "description": "Bristol’s urban rats are so smart they raid bins right after people throw out food!"
    },
  ];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // **Page Title & Fun Intro**
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "🌍 Bristol’s Urban Wildlife: Fun Facts!",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Did you know that Bristol’s wildlife is always adapting to the human world?\n\n"
                    "From foxes dodging traffic like pros to rats mastering the city’s waste system, "
                    "discover how these clever animals thrive in our urban jungle! 🔍",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // **Foxes Fact Section**
            _buildFactCard("Foxes - The Adaptive Survivors", "assets/images/fox.jpg", foxFacts, _foxController, _currentFoxIndex, (index) {
              setState(() {
                _currentFoxIndex = index;
              });
            }),

            // **Rats Fact Section**
            _buildFactCard("Rats - The Hidden Navigators", "assets/images/rat.webp", ratFacts, _ratController, _currentRatIndex, (index) {
              setState(() {
                _currentRatIndex = index;
              });
            }),

            // **Navigation Buttons (Back & Next)**
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    label: const Text('Back', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 13, 87, 15),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CustomisePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 13, 87, 15),
                    ),
                    child: Row(
                      children: const [
                        Text('Next', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 5),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 // **Fact Card with Swiping & 'Next' + 'Back' Arrows**
// **Fact Card with Improved Text Alignment & Styling**
Widget _buildFactCard(
  String title,
  String imagePath,
  List<Map<String, String>> facts,
  PageController controller,
  int currentIndex,
  Function(int) onPageChanged,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
    child: Container(
      height: 220, // Increased height slightly for better spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)], // Adds subtle shadow for depth
      ),
      padding: const EdgeInsets.all(20),

      child: Column(
        children: [
          // **Title**
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center, // Center-align the title
              style: const TextStyle(
                fontSize: 22, // Increased font size
                fontWeight: FontWeight.bold, // Makes it stand out more
              ),
            ),
          ),
          const SizedBox(height: 10),

          // **Fact Content with Swiping**
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: facts.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Center-align content vertically
                  children: [
                    Text(
                      facts[index]["title"]!,
                      textAlign: TextAlign.center, // Center-align text
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      facts[index]["description"]!,
                      textAlign: TextAlign.center, // Center-align description
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // **Navigation Arrows & Page Indicator**
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // **Back Arrow**
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black54, size: 24),
                onPressed: () {
                  if (currentIndex > 0) {
                    controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
              ),

              // **Page Indicator (3 Dots)**
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  facts.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index ? Colors.green : Colors.grey,
                    ),
                  ),
                ),
              ),

              // **Next Arrow**
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.black54, size: 24),
                onPressed: () {
                  if (currentIndex < facts.length - 1) {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}