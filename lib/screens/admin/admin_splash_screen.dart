import 'package:flutter/material.dart';

class AdminSplashScreen extends StatefulWidget {
  const AdminSplashScreen({Key? key}) : super(key: key);

  @override
  _AdminSplashScreenState createState() => _AdminSplashScreenState();
}

class _AdminSplashScreenState extends State<AdminSplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, 'admin-home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250, // Adjust the desired width
              height: 250, // Adjust the desired height
              child: Image.asset(
                'assets/images/newlogo.png',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "NFC Pay",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 150),
            const CircularProgressIndicator(
              color: Colors.red,
            ),
            const SizedBox(height: 8),
            const Text(
              "Loading...",
            ),
          ],
        ),
      ),
    );
  }
}
