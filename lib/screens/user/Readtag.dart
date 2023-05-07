import 'dart:convert';

import 'package:flutter/material.dart';

import '../../NFC/services/nfc_services.dart';
import '../pop_ups/nfc_scanning_popup.dart';

class ReadNFCTag extends StatefulWidget {
  @override
  State<ReadNFCTag> createState() => _ReadNFCTagState();
}

class _ReadNFCTagState extends State<ReadNFCTag> {
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
      final userData = jsonDecode(userDataJson);
      userDataList.value = [userData];
    } catch (e) {
      print('Error reading NFC tag: $e');
    }

    setState(() {
      isSearching = false;
    });

    if (!isSearching) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text('NFC Data'),
      ),
      body: Center(
        child: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: userDataList,
          builder: (context, userDataList, child) {
            if (userDataList.isEmpty) {
              return const Text(
                'Tap an NFC tag to read data',
                style: TextStyle(
                  fontSize: 50,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _extractNfcData,
        child: const Icon(Icons.nfc),
      ),
    );
  }
}
