import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'authentication/services/auth_services.dart';
import 'homescreen.dart';
import 'screens/admin/admin_home.dart';
import 'screens/admin/admin_login.dart';
import 'screens/admin/admin_signup.dart';
import 'screens/admin/pages/about.dart';
import 'screens/admin/pages/admin_read.dart';
import 'screens/admin/settings/admin_account_settings.dart';
import 'screens/admin/settings/app_settings.dart';
import 'screens/user/user.dart';
import 'splash_screen.dart';

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

  const MyApp({required this.loggedIn, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NFC Management",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'home': (context) => const HomeScreen(),
        'user': (context) => const UserScreen(),
        'admin-login': (context) => const AdminLogin(),
        'admin-signup': (context) => const AdminSignUp(),
        'admin-home': (context) => AdminHomeScreen(),
        'admin_read_nfc': (context) => AdminRead(),
        'admin_account_settings': (context) =>
            const AdminAccountSettingsScreen(),
        'app_settings': (context) => AppSettingsScreen(),
        'about': (context) => AboutScreen(),
      },
    );
  }
}
