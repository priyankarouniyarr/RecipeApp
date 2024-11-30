import 'package:flutter/material.dart';
import 'package:recip_app/screen/home.dart';

class RecipeSplashScreen extends StatelessWidget {
  const RecipeSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.85),
                  Colors.black.withOpacity(0.3),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(seconds: 2),
                      child: Hero(
                        tag: "logo",
                        child: Icon(
                          Icons.local_restaurant_rounded,
                          color: Colors.white,
                          size: 120,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(seconds: 2),
                      child: const Text(
                        "Recipe Master",
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 15,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Your Journey to Culinary Excellence",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RecipeHomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    backgroundColor: Colors.green.shade700,
                    shadowColor: Colors.amber.shade400,
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(
                      color: Colors.white60,
                      width: 1.5,
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Column(
                  children: const [
                    Text(
                      "Crafted with Love ❤ by Recipe Master Team",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
