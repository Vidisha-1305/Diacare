// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash delay
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;
    if (user != null) {
      // ✅ User is already signed in → go to Home
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // ❌ User not signed in → go to Login
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png', // Replace with your logo path
              height: 120,
            ),
            const SizedBox(height: 30),
            const Text(
              'MediCare App', // Replace with your app name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
