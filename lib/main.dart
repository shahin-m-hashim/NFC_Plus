import 'package:flutter/material.dart';

import 'splash_screen.dart';

const save_key_name = "LoggedIn";

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}
