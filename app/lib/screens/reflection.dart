import 'package:app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class ReflectionsPage extends StatelessWidget {
  const ReflectionsPage({super.key});

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

        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **Back Button**
              Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  label: const Text("Back", style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 13, 87, 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // **Title & Summary**
              const Center(
                child: Text(
                  "Your Choices, Your Impact 🌍",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 15),
              const SizedBox(height: 30),

              // **Final Thoughts & Real-World Impact**
              const Text(
                "What Can You Do? 🚀",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                "Bristol’s wildlife constantly adapts to urban change. But every action we take plays a role in shaping the environment.",
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),

              // **Action List**
              _actionListItem("Reduce waste by disposing of litter properly."),
              _actionListItem("Support Bristol’s green spaces & wildlife initiatives."),
              _actionListItem("Be mindful of food waste—less waste means fewer scavengers."),

              const SizedBox(height: 30),

              // **Further Resources**
              const Text(
                "Learn More 📚",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              _resourceLink("Wildlife Trust Bristol", "https://www.avonwildlifetrust.org.uk/"),
              _resourceLink("Bristol Waste & Sustainability", "https://www.bristolwastecompany.co.uk/"),
              _resourceLink("Urban Wildlife Research", "https://www.bristol.ac.uk/biology/research/"),

              const SizedBox(height: 40),

              // **Back to Home Button**
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 34, 92, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),

                  ),
                  onPressed: () {
                    Navigator.pop(context);
                     Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // **Reusable Action List Item**
  static Widget _actionListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(color: Colors.black, fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // **Reusable Resource Link**
  static Widget _resourceLink(String title, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        child: Text("$title: $url",
        style: const TextStyle(fontSize: 14, color: Colors.black, decoration: TextDecoration.underline),
      ),
      onTap: () async{
          final Uri uri = Uri.parse(url);
          launchUrl(uri);
      }
    ));
  }
}
