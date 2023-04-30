import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/addtodoscreen.dart';
import 'screens/homescreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Enable offline persistence
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local Database SQL",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/add_todo': (context) => AddTodoScreen(),
      },
    );
  }
}
