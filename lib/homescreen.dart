import 'package:flutter/material.dart';
import 'package:mastering_flutter/screens/pop_ups/nfc_availabilty_popup.dart';

import 'NFC/services/nfc_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool IsNfcAvailable = false;

  @override
  void initState() {
    super.initState();
    _showNfcAvailabilityPopup();
  }

  Future<void> checkNfcAvailability() async {
    final bool isAvailable = await isNfcAvailable();
    setState(() {
      IsNfcAvailable = isAvailable;
    });
  }

  void _showNfcAvailabilityPopup() async {
    await checkNfcAvailability();
    if (!IsNfcAvailable) {
      showDialog(
        context: context,
        barrierDismissible: false,
        // prevent dialog from being dismissed by tapping outside of it
        builder: (BuildContext context) {
          return const NfcAvailabilityPopup();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC pay'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'admin-login');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red), // Set the background color
                ),
                child: const Text(
                  'ADMIN',
                  style: TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'user');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.green), // Set the background color
                ),
                child: const Text(
                  'USER',
                  style: TextStyle(
                    fontSize: 50,
                    letterSpacing: 5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
