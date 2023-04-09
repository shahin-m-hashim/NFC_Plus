import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'database/model/todo_model.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //initialize Hive
  if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  // the if statement will only execute Hive.registerAdapter(TodoModelAdapter()); if the adapter
  // is not registered (!Hive.isAdapterRegistered(TodoModelAdapter().typeId) is true.
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
