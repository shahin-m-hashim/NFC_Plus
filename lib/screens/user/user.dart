// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mastering_flutter/screens/pop_ups/nfc_scanning_popup.dart';
import 'package:mastering_flutter/screens/pop_ups/nfc_tag_popups.dart';

import '../../NFC/services/nfc_services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isSearching = false;
  bool isTagAvailable = false;
  final String userDataJson =
      '{"to": "Ajmal Sajeev","day": "May 4 2023","time":"5:42 PM" ,"uid": 3182923, "gid": "CIgD_2eVw"}';

  Future<void> _onSendDataPressed() async {
    setState(() {
      isSearching = true;
    });

    // Show the NFC searching popup if `isSearching` is true
    if (isSearching) {
      // print("Searching started $isSearching");
      NfcScanningPopup.NfcSearchingIndicator(context);
    }

    bool tagAvailable = await writeNfcTagIfAvailable(userDataJson);

    setState(() {
      isTagAvailable = tagAvailable;
      isSearching = false;
    });

    // Pop off the NFC searching popup if `isTagAvailable` is true and send data
    if (isTagAvailable) {
      Navigator.pop(context);
      NFCPopups.NfcTagFoundPopup(context);
    } else {
      Navigator.pop(context);
      NFCPopups.NfcTagNotFoundPopup(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = json.decode(userDataJson);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('NFC User'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 380,
              height: 470,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'USER DATA',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To:',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData['to'],
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Date:',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData['day'],
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Time:',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData['time'],
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'UPI Transaction ID:',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData['uid'].toString(),
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Google Transaction ID:',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            userData['gid'],
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.grey[800],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 340,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onSendDataPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'SEND DATA',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 340,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, 'user-read');
                      // Do something with the data
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'READ NFC',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
