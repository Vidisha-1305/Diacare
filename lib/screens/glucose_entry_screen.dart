import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/glucose_entry.dart';
import '../helpers/storage_helper.dart';

class GlucoseEntryScreen extends StatefulWidget {
  const GlucoseEntryScreen({super.key});

  @override
  _GlucoseEntryScreenState createState() => _GlucoseEntryScreenState();
}

class _GlucoseEntryScreenState extends State<GlucoseEntryScreen> {
  final TextEditingController _controller = TextEditingController();
  List<GlucoseEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final loadedEntries = await StorageHelper.loadGlucoseEntries();
    setState(() {
      _entries = loadedEntries;
    });
  }

  Future<void> _addEntry() async {
    if (_controller.text.isEmpty) return;

    final value = double.tryParse(_controller.text);
    if (value == null) return;

    final newEntry = GlucoseEntry(value: value, date: DateTime.now());

    setState(() {
      _entries.add(newEntry);
    });

    await StorageHelper.saveGlucoseEntries(_entries);
    _controller.clear();
  }

  Future<void> _editEntry(int index) async {
    final TextEditingController editController =
        TextEditingController(text: _entries[index].value.toString());

    final newValue = await showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Glucose Value'),
          content: TextField(
            controller: editController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Glucose Value',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = double.tryParse(editController.text);
                Navigator.pop(context, value);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    if (newValue != null) {
      setState(() {
        _entries[index] =
            GlucoseEntry(value: newValue, date: DateTime.now());
      });
      await StorageHelper.saveGlucoseEntries(_entries);
    }
  }

  Future<void> _deleteEntry(int index) async {
    setState(() {
      _entries.removeAt(index);
    });
    await StorageHelper.saveGlucoseEntries(_entries);
  }

  Widget _buildChart() {
    if (_entries.isEmpty) {
      return Center(child: Text("No data yet"));
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true, reservedSize: 40),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: _entries.asMap().entries.map((e) {
                  return FlSpot(
                    e.key.toDouble(),
                    e.value.value,
                  );
                }).toList(),
                barWidth: 3,
                color: Colors.blue,
                belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Glucose Entry')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Glucose Value',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _addEntry,
            child: Text('Add Entry'),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildChart(),
                Divider(),
                ..._entries.asMap().entries.map((e) {
                  final index = e.key;
                  final entry = e.value;
                  return ListTile(
                    title: Text('${entry.value} mg/dL'),
                    subtitle: Text(entry.date.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editEntry(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteEntry(index),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
