import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GlucoseChartScreen extends StatelessWidget {
  const GlucoseChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final glucoseBox = Hive.box('glucose_logs');

    // Convert Hive data into a list
    final entries = glucoseBox.values.toList();

    // Prepare data points (x = index, y = glucose value)
    List<FlSpot> spots = [];
    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final value = double.tryParse(entry.toString()) ?? 0.0;
      spots.add(FlSpot(i.toDouble(), value));
    }

    return Scaffold(
      appBar: AppBar(title: Text("Glucose Trends")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: spots.isEmpty
            ? Center(child: Text("No glucose data yet"))
            : LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blue,
                      belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
