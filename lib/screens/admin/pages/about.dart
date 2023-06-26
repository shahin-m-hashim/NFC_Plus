import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nfc_plus.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 16.0),
            // const Text(
            //   'NFC Plus',
            //   style: TextStyle(
            //     fontSize: 24.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 8.0),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Welcome to our NFC-based application! Our app combines the features of NFC technology with user-friendly interfaces to provide a seamless experience for both users and administrators.\n\nOur NFC-based application simplifies transaction management using NFC technology. Users can generate random transaction details and send them to nearby NFC tags. Admins have secure access to read and store transaction data. The app provides a user-friendly dashboard with insights on income and transactions.\n\nWe value your feedback as we strive to enhance the apps functionality. Thank you for choosing our NFC-based app for seamless transaction management.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
