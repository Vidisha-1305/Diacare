import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/glucose_entry.dart';

class StorageHelper {
  static const String _glucoseKey = 'glucose_entries';

  // Save list of entries
  static Future<void> saveGlucoseEntries(List<GlucoseEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = entries.map((entry) => jsonEncode(entry.toMap())).toList();
    await prefs.setStringList(_glucoseKey, entriesJson);
  }

  // Load list of entries
  static Future<List<GlucoseEntry>> loadGlucoseEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final entriesJson = prefs.getStringList(_glucoseKey);

    if (entriesJson == null) return [];

    return entriesJson
        .map((entry) => GlucoseEntry.fromMap(jsonDecode(entry)))
        .toList();
  }
}
