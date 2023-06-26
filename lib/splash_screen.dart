import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacementNamed(context, 'home');
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
                'assets/images/nfc_plus.png',
              ),
            ),
            const SizedBox(height: 160),
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
