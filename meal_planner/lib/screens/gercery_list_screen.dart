import 'package:flutter/material.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<Map<String, String>> ingredients = [
    {"name": "Chicken breasts", "amount": "250 g"},
    {"name": "Unsalted butter", "amount": "1 tbsp"},
    {"name": "Sesame oil", "amount": "2 tsp"},
    {"name": "Fresh ginger", "amount": "2 tsp"},
    {"name": "Large eggs", "amount": "100 g"},
  ];

  late List<bool> checked;

  @override
  void initState() {
    super.initState();
    checked = List<bool>.filled(ingredients.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery List"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final item = ingredients[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: index < checked.length ? checked[index] : false,
                  onChanged: (val) {
                    if (index < checked.length) {
                      setState(() {
                        checked[index] = val!;
                      });
                    }
                  },
                  activeColor: const Color(0xFF8649FF),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item["name"]!, style: const TextStyle(fontSize: 16)),
                      Text(item["amount"]!,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    if (index < ingredients.length && index < checked.length) {
                      setState(() {
                        ingredients.removeAt(index);
                        checked.removeAt(index);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Color(0xFF8649FF),
                          content: Text(
                            "Item removed from the list",
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add item logic (optional)
        },
        backgroundColor: const Color(0xFF8649FF),
        child: const Icon(Icons.add),
      ),
    );
  }
}
