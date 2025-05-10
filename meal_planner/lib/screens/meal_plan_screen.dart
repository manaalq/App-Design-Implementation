import 'package:flutter/material.dart';
import 'package:meal_planner/screens/Recipe_detail_screen.dart';
import 'package:meal_planner/screens/sittings_screen.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  final List<String> mealNames = ['Ramen Noodles', 'Avocado Toast'];
  final List<String> imagePaths = [
    'assets/images/egg_food.png',
    'assets/images/Rectangle 90.png',
  ];

  List<bool> _isFavorite = [false, false];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          title: const Text("Meal Plan"),
          bottom: const TabBar(
            indicatorColor: Color(0xFF8649FF),
            labelColor: Color(0xFF8649FF),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "All Meals"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMealList(context),
            _buildFavoritesList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMealList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF8649FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: const [
              Icon(Icons.emoji_events, color: Colors.yellow, size: 40),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "You have won 5 days free trial of the daily diet plan. Enjoy!",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        for (int i = 0; i < imagePaths.length; i++)
          Column(
            children: [
              _buildMealImage(imagePaths[i], mealNames[i], i),
              const SizedBox(height: 20),
            ],
          ),
      ],
    );
  }

  Widget _buildFavoritesList(BuildContext context) {
    final favoriteMeals = imagePaths
        .asMap()
        .entries
        .where((entry) => _isFavorite[entry.key])
        .toList();

    if (favoriteMeals.isEmpty) {
      return const Center(child: Text("No favorites yet."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: favoriteMeals.length,
      itemBuilder: (context, index) {
        final realIndex = favoriteMeals[index].key;
        return Column(
          children: [
            _buildMealImage(
              imagePaths[realIndex],
              mealNames[realIndex],
              realIndex,
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget _buildMealImage(String path, String name, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                path,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black54,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const RecipeDetailScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8649FF),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "View Recipe",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: Icon(
                _isFavorite[index]
                    ? Icons.favorite
                    : Icons.favorite_border_outlined,
                color: _isFavorite[index]
                    ? const Color(0xFF8649FF)
                    : Colors.grey.shade600,
              ),
              onPressed: () {
                setState(() {
                  _isFavorite[index] = !_isFavorite[index];
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
