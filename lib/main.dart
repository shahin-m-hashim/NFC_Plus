import 'package:flutter/material.dart';
import 'screens/Readtag.dart';
import 'screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NFC Management",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        'nfc_read': (context) => ReadNFCTag(),
      },
    );
  }
}
