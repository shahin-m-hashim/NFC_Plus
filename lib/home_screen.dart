import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homescreen"),
        backgroundColor: const Color.fromARGB(255, 11, 192, 102),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                signOut(context);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      backgroundColor: Colors.amber,
      body: const SafeArea(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}

signOut(BuildContext ctx) async {
  final _sharedPrefs = await SharedPreferences.getInstance();
  await _sharedPrefs.clear();

  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx1) => LogIn(),
      ),
      (route) => false);
}
