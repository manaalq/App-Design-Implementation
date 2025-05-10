import 'package:flutter/material.dart';
import 'package:meal_planner/screens/sittings_screen.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showRealImages = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showRealImages = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 60),
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Today"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 20),
            // Progress Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + View more
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Today’s Progress",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("View more", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Calories + Circles
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department),
                      const SizedBox(width: 6),
                      const Text("1,284",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      _buildCircle("Fat", 29, Colors.orange),
                      _buildCircle("Pro", 65, Colors.blue),
                      _buildCircle("Carb", 85, Colors.purple),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Encouragement
                  Row(
                    children: const [
                      CircleAvatar(
                          radius: 16,
                          backgroundImage:
                              AssetImage('assets/images/profile.webp')),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "🎉 Keep the pace! You're doing great.",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Meal Cards
            _buildMealImage('assets/images/Img1.png'),
            const SizedBox(height: 12),
            _buildMealImage('assets/images/Rectangle 90.png'),
          ],
        ),
      ),
    );
  }

  static Widget _buildCircle(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 36,
                width: 36,
                child: CircularProgressIndicator(
                  value: value / 100,
                  color: color,
                  backgroundColor: Colors.grey.shade300,
                  strokeWidth: 4,
                ),
              ),
              Text("$value%", style: const TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMealImage(String path) {
    return _showRealImages
        ? ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              path,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
  }
}
