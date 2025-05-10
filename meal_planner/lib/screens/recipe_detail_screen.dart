import 'package:flutter/material.dart';
import 'package:meal_planner/screens/gercery_list_screen.dart';
import 'package:meal_planner/screens/preparation_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            // Recipe image with back and menu icons
            Stack(
              children: [
                Image.asset(
                  'assets/images/egg_food.png',
                  height: 260,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Positioned(
                  top: 16,
                  right: 16,
                  child: Icon(Icons.more_horiz, color: Colors.black),
                ),
              ],
            ),

            // Title and description
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Column(
                children: const [
                  Text(
                    'Ramen',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Lunch / 15 mins',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Nutritional info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _NutritionInfo(label: 'Energy', value: '100 k'),
                  _NutritionInfo(label: 'Protein', value: '15 g'),
                  _NutritionInfo(label: 'Carbs', value: '58 g'),
                  _NutritionInfo(label: 'Fat', value: '20 g'),
                ],
              ),
            ),

            const Divider(),

            // Ingredients list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        "Ingredients",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Text("2 serves", style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      Icon(Icons.remove),
                      SizedBox(width: 6),
                      Icon(Icons.add),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ingredientItem("Chicken breasts", "250 g"),
                  _ingredientItem("Unsalted butter", "1 tbsp"),
                  _ingredientItem("Sesame or vegetable oil", "2 tsp"),
                  _ingredientItem("Fresh ginger", "2 tsp"),
                  _ingredientItem("Large eggs", "100 g", disabled: true),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Button: Add ingredients to grocery list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Color(0xFF8649FF),
                      content: Text(
                        "Ingredients added to grocery list",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GroceryListScreen()));
                },
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF8649FF),
                ),
                label: const Text(
                  "Add ingredients to grocery list",
                  style: TextStyle(color: Color(0xFF8649FF), fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Button: Start Cooking
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8649FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PreparionScreen()));
                },
                child: const Text(
                  'Start cooking',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Ingredient item UI widget
  static Widget _ingredientItem(String title, String amount,
      {bool disabled = false}) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 15)),
            Text(amount,
                style: const TextStyle(fontSize: 15, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// Nutritional info widget
class _NutritionInfo extends StatelessWidget {
  final String label;
  final String value;

  const _NutritionInfo({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
