import 'package:flutter/material.dart';

class InsulinCalculatorScreen extends StatefulWidget {
  const InsulinCalculatorScreen({super.key});

  @override
  _InsulinCalculatorScreenState createState() => _InsulinCalculatorScreenState();
}

class _InsulinCalculatorScreenState extends State<InsulinCalculatorScreen> {
  final _glucoseController = TextEditingController();
  final _carbsController = TextEditingController();

  // User configurable values (later we can move this to settings screen)
  double targetGlucose = 110; // mg/dL
  double sensitivityFactor = 50; // 1 unit insulin lowers 50 mg/dL
  double carbRatio = 10; // 1 unit insulin covers 10g carbs

  String result = "";

  void _calculateInsulin() {
    final glucose = double.tryParse(_glucoseController.text);
    final carbs = double.tryParse(_carbsController.text);

    if (glucose == null || carbs == null) {
      setState(() {
        result = "Please enter valid numbers.";
      });
      return;
    }

    // Formula:
    double correctionDose = (glucose - targetGlucose) / sensitivityFactor;
    double mealDose = carbs / carbRatio;
    double totalInsulin = correctionDose + mealDose;

    if (totalInsulin < 0) totalInsulin = 0;

    setState(() {
      result = "Recommended Insulin: ${totalInsulin.toStringAsFixed(2)} units";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insulin Dose Calculator"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _glucoseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Current Glucose (mg/dL)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _carbsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Carbs Intake (grams)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _calculateInsulin,
                child: Text("Calculate"),
              ),
            ),
            SizedBox(height: 24),
            Text(
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
