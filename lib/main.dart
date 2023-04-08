import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter(); //intialize Hive
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local Database",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
