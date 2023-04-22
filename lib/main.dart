import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'sql_functions/db_functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OpenDB();
  await get_all_todo_from_db();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local Database Hive",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
