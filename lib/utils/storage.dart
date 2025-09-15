// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/glucose_entry.dart';

// class Storage {
//   static const String key = 'glucose_entries';

//   static Future<List<GlucoseEntry>> loadEntries() async {
//     final prefs = await SharedPreferences.getInstance();
//     final jsonString = prefs.getString(key);
//     if (jsonString == null) return [];
//     final List decoded = jsonDecode(jsonString);
//     return decoded.map((e) => GlucoseEntry.fromJson(e)).toList();
//   }

//   static Future<void> saveEntry(GlucoseEntry entry) async {
//     final prefs = await SharedPreferences.getInstance();
//     final entries = await loadEntries();
//     entries.add(entry);
//     final jsonString = jsonEncode(entries.map((e) => e.toJson()).toList());
//     await prefs.setString(key, jsonString);
//   }
// }
