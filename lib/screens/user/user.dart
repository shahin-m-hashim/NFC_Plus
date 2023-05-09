// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mastering_flutter/screens/pop_ups/nfc_scanning_popup.dart';
import 'package:mastering_flutter/screens/pop_ups/nfc_tag_popups.dart';

import '../../NFC/services/nfc_services.dart';
import '../pop_ups/random_transaction_popup.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isSearching = false;
  bool isTagAvailable = false;
  late String smallDate = '';
  late String fullDate = '';
  late String formattedTime = '';
  late String userDataJson = '';
  late String nm = 'Ajmal Sajeev';
  late int amt = 250;
  late int ti = 3185182923;

  void getCurrentDateTime() {
    final now = DateTime.now();
    final DateFormat smallDateFormat = DateFormat('M/d/yy');
    final DateFormat fullDateFormat = DateFormat('MMMM dd yyyy');

    smallDate =
        smallDateFormat.format(now); // Convert to smaller format: 2/25/23

    // Convert back to full format: February 25 2023
    final DateTime parsedDate = smallDateFormat.parse(smallDate);
    fullDate = fullDateFormat.format(parsedDate);

    formattedTime = DateFormat('h:mm a').format(now);
  }

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
    final Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (data != null) {
      nm = data['name'];
      amt = data['amount'];
      ti = data['tid'];
    }

    getCurrentDateTime();
    userDataJson =
        '{"to": "$nm", "day": "$smallDate", "time": "$formattedTime", "ti": $ti, "amt": $amt}';

    print(userDataJson.toString());

    final userData = json.decode(userDataJson);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('NFC User'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 30),
              Container(
                width: 380,
                height: 450,
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
                          'TRANSACTION DETAILS',
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
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
                              fullDate,
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
                              userData['ti'].toString(),
                              style: TextStyle(
                                fontSize: 23,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Total Amount Paid:',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              ' ₹${userData['amt'].toString()}',
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
                  const SizedBox(height: 20),
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
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 340,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return RandomTransactionPopup(
                              onSubmit: (values) {
                                setState(() {
                                  nm = values['name'];
                                  amt = values['amount'];
                                  ti = values['tid'];
                                });
                              },
                            );
                          },
                        );
                        if (result != null) {
                          setState(() {
                            nm = result['name'];
                            amt = result['amount'];
                            ti = result['tid'];
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'GENERATE RANDOM TRANSACTION',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
