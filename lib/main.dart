import 'package:diacare/screens/login_screen.dart';
import 'package:diacare/screens/signup_screen.dart';
import 'package:diacare/screens/suggest_food.dart';
import 'package:diacare/splash_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/glucose_entry_screen.dart';
import 'screens/tips_screen.dart';
import 'screens/logs_screen.dart';
import 'screens/emergency_screen.dart';
import 'screens/insulin_calculator_screen.dart';
import 'screens/glucose_chart_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
// Add Hive import if missing
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openBox('glucose_logs');

  // Run the app
  runApp(const DiaCareApp());
}

class DiaCareApp extends StatelessWidget {
  const DiaCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diacare App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => HomeScreen(),
        '/glucose_entry': (context) => GlucoseEntryScreen(),
        '/emergency': (context) => EmergencyScreen(),
        '/calculator': (context) => InsulinCalculatorScreen(),
        '/tips': (context) => TipsScreen(),
        '/logs': (context) => LogsScreen(),
        '/chart': (context) => GlucoseChartScreen(),
        '/food_suggestions': (context) => SuggestFood(),
      },
    );
  }
}
