import 'package:flutter/material.dart';

class NfcScanningPopup {
  static void NfcSearchingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            height: 340,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(2),
            child: Center(
              child: Column(
                //mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 15),
                  const Text(
                    'Searching NFC Tag',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Image.asset(
                    'assets/images/nfc_radar.gif',
                    width: 200,
                    height: 200,
                  ),
                  //const SizedBox(height: 10),
                  const Divider(
                    thickness: 2,
                    color: Color.fromARGB(255, 70, 66, 66),
                  ),
                  //const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    width: 250,
                    height: 40,
                    color: Colors.red,
                    child: const Text(
                      'TAP the NFC tag',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
