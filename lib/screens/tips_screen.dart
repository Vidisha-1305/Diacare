import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  final List<String> tips = const [
    "Drink water to lower high sugar levels.",
    "Check sugar before meals and sleep.",
    "Keep emergency snacks if sugar drops.",
    "Don't skip insulin doses.",
    "Exercise regularly (but safely)."
  ];

  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diabetes Tips')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                tips[index],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          );
        },
      ),
    );
  }
}

