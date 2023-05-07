import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NfcAvailabilityPopup extends StatelessWidget {
  const NfcAvailabilityPopup({Key? key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // disable the back button
        return false;
      },
      child: AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Enable NFC',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.error,
              color: Colors.red,
              size: 48,
            ),
            SizedBox(height: 25),
            Text(
              'Sorry, your device does not support NFC or its disabled.The App Requires NFC to function properly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.w40,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text(
              'Exit',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }
}
