import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/services/auth_services.dart';
import 'screens/homescreen.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize Firebase
  await Firebase.initializeApp();

  // Check Whether User Logged In Or Not
  bool loggedIn = await AuthService().isLoggedIn();

  runApp(MyApp(loggedIn: loggedIn));
}

class MyApp extends StatelessWidget {
  final bool loggedIn;

  const MyApp({Key? key, required this.loggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Authentication",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: loggedIn ? 'home' : '/',
      routes: {
        '/': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
        'sign_up': (context) => SignUpScreen(),
      },
    );
  }
}
