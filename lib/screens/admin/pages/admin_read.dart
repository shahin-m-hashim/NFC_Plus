// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../NFC/database/transaction_db_helper.dart';
import '../../../NFC/models/user_transaction_model.dart';
import '../../../NFC/services/nfc_services.dart';
import '../../pop_ups/nfc_scanning_popup.dart';
import '../../pop_ups/nfc_tag_popups.dart';

class AdminRead extends StatefulWidget {
  final void Function(bool isActive) updateNotificationState;

  const AdminRead({required this.updateNotificationState});

  @override
  State<AdminRead> createState() => _AdminReadState();
}

class _AdminReadState extends State<AdminRead> {
  final ValueNotifier<List<Map<String, dynamic>>> userDataList =
      ValueNotifier<List<Map<String, dynamic>>>([]);
  bool isSearching = false;
  bool extract = false;

  String convertToFullDate(String smallDate) {
    final DateFormat smallDateFormat = DateFormat('M/d/yy');
    final DateFormat fullDateFormat = DateFormat('MMMM dd yyyy');

    final DateTime parsedDate = smallDateFormat.parse(smallDate);
    final String fullDate = fullDateFormat.format(parsedDate);

    return fullDate;
  }

  Future<void> _storeUserDataInDatabase(Map<String, dynamic> userData) async {
    try {
      // Convert the small date format to full date format
      final String fullDate = convertToFullDate(userData['day']);

      // Create a UserTransactionModel object from the extracted data
      final UserTransactionModel userTransactionModel = UserTransactionModel(
        To: userData['to'],
        Date: fullDate,
        Time: userData['time'],
        UPI_Transaction_Id: userData['ti'],
        Amount_Paid: userData['amt'],
      );

      // Store the UserTransactionModel object in the Users collection
      final bool dataInserted =
          await TransactionDBHelper.insert(userTransactionModel);

      if (dataInserted) {
        widget.updateNotificationState(true);
      }
    } catch (error) {
      // Handle error
    }
  }

  Future<void> _extractNfcData() async {
    setState(() {
      isSearching = true;
    });

    if (isSearching) {
      NfcScanningPopup.NfcSearchingIndicator(context);
    }

    try {
      final String userDataJson = await readNfcTag();

      if (userDataJson == 'empty' || userDataJson == '{}') {
        // Tag data is empty
        setState(() {
          isSearching = false;
        });
        Navigator.pop(context);
        NFCPopups.NfcTagDataEmptyPopup(context);
        return; // Exit the function
      }

      final userData = jsonDecode(userDataJson);
      userDataList.value = [userData];
      extract = true;

      // Store the user data in the database
      await _storeUserDataInDatabase(userData);
    } catch (e) {
      setState(() {
        isSearching = false;
      });
      Navigator.pop(context);
      NFCPopups.NfcTagNotFoundPopup(context);
      return; // Exit the function
    }

    if (extract) {
      setState(() {
        isSearching = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: userDataList,
          builder: (context, userDataList, child) {
            if (userDataList.isEmpty || userDataList[0].isEmpty) {
              return const Text(
                'No Transactions Has Been Received Today, Scan Your Customer Tag.',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              );
            } else {
              final userData = userDataList[0];
              final String fullDate = convertToFullDate(userData['day']);
              final List<Map<String, dynamic>> userDataItems = [
                {'title': 'From', 'value': userData['to']},
                {'title': 'Date', 'value': fullDate},
                {'title': 'Time', 'value': userData['time']},
                {
                  'title': 'UPI Transaction ID',
                  'value': userData['ti'].toString()
                },
                {
                  'title': 'Total Amount Paid',
                  'value': userData['amt'].toString()
                },
                // add more items here as needed
              ];
              return ListView.separated(
                itemCount: userDataItems.length,
                itemBuilder: (context, index) {
                  final item = userDataItems[index];
                  return ListTile(
                    tileColor: Colors.amber,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8), // Add vertical spacing
                        Text(
                          item['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8), // Add vertical spacing
                        Text(
                          item['value'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black,
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _extractNfcData,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 201, 102, 206),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'START Scanning',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
