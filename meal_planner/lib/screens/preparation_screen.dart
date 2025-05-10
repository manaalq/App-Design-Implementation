import 'package:flutter/material.dart';

class PreparionScreen extends StatefulWidget {
  const PreparionScreen({super.key});

  @override
  State<PreparionScreen> createState() => _PreparionScreenState();
}

class _PreparionScreenState extends State<PreparionScreen> {
  int currentStep = 1;

  final List<List<Map<String, String>>> stepIngredients = [
    [
      {"Tomato": "2 pcs"},
      {"Olive Oil": "1 tbsp"},
    ],
    [
      {"Onion": "1 pc"},
      {"Garlic": "2 cloves"},
    ],
    [
      {"Pasta": "200 g"},
      {"Salt": "1 tsp"},
    ],
    [
      {"Bacon": "50 gr"},
      {"Soy Sauce": "200 ml"},
    ]
  ];

  final List<String> stepDescriptions = [
    "Chop the tomatoes and heat olive oil in a pan.",
    "Add onions and garlic, sauté until golden.",
    "Boil pasta with a pinch of salt.",
    "We tie the bacon with twine... discard the oil.",
  ];

  void changeStep(int step) {
    setState(() {
      currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = stepIngredients[currentStep - 1];
    final description = stepDescriptions[currentStep - 1];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(24)),
                child: Image.asset(
                  'assets/images/edgar-castrejon-1SPu0KT-Ejg-unsplash 9.png',
                  height: 340,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                bottom: 20,
                left: 20,
                child: Icon(Icons.pause_circle_filled,
                    size: 36, color: Colors.white),
              ),
              const Positioned(
                bottom: 20,
                right: 20,
                child: Text("3:21", style: TextStyle(color: Colors.white)),
              ),
              const Positioned(
                top: 20,
                right: 20,
                child: Icon(Icons.fullscreen, color: Colors.white),
              ),
            ],
          ),

          // Step content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Step $currentStep",
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 12),

                  // Step indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      final isActive = currentStep == (index + 1);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: GestureDetector(
                          onTap: () => changeStep(index + 1),
                          child: _StepCircle(
                            number: "${index + 1}",
                            isActive: isActive,
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  // Ingredients
                  ...ingredients.map((item) {
                    final name = item.keys.first;
                    final amount = item.values.first;
                    return _IngredientRow(name: name, amount: amount);
                  }).toList(),

                  const Divider(),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    description,
                    style: const TextStyle(fontSize: 15, height: 1.5),
                  ),

                  const Spacer(),

                  // Navigation Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: currentStep > 1
                              ? () => changeStep(currentStep - 1)
                              : null,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text("Previous",
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: const Text(
                            "Finish cook",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8649FF),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Step circle widget
class _StepCircle extends StatelessWidget {
  final String number;
  final bool isActive;

  const _StepCircle({required this.number, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor:
          isActive ? const Color(0xFF8649FF) : Colors.grey.shade200,
      child: Text(
        number,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Ingredient row widget
class _IngredientRow extends StatelessWidget {
  final String name;
  final String amount;

  const _IngredientRow({required this.name, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(amount, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
