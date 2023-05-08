// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../NFC/services/nfc_services.dart';
import '../../pop_ups/nfc_scanning_popup.dart';
import '../../pop_ups/nfc_tag_popups.dart';

class AdminRead extends StatefulWidget {
  @override
  State<AdminRead> createState() => _AdminReadState();
}

class _AdminReadState extends State<AdminRead> {
  final ValueNotifier<List<Map<String, dynamic>>> userDataList =
      ValueNotifier<List<Map<String, dynamic>>>([]);
  bool isSearching = false;
  bool extract = false;

  Future<void> _extractNfcData() async {
    setState(() {
      isSearching = true;
    });

    if (isSearching) {
      NfcScanningPopup.NfcSearchingIndicator(context);
    }

    try {
      final String userDataJson = await readNfcTag();

      // print(userDataJson);

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
              final List<Map<String, dynamic>> userDataItems = [
                {'title': 'To', 'value': userData['to']},
                {'title': 'Date', 'value': userData['day']},
                {'title': 'Time', 'value': userData['time']},
                {
                  'title': 'UPI Transaction ID',
                  'value': userData['uid'].toString()
                },
                {'title': 'Google Transaction ID', 'value': userData['gid']},
                // add more items here as needed
              ];
              return ListView.separated(
                itemCount: userDataItems.length,
                itemBuilder: (context, index) {
                  final item = userDataItems[index];
                  return ListTile(
                    tileColor: Colors.amber,
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      item['value'],
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
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
