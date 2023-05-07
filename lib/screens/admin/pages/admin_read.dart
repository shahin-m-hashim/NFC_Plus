import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../NFC/services/nfc_services.dart';

class AdminRead extends StatefulWidget {
  @override
  State<AdminRead> createState() => _AdminReadState();
}

class _AdminReadState extends State<AdminRead> {
  final ValueNotifier<List<Map<String, dynamic>>> userDataList =
      ValueNotifier<List<Map<String, dynamic>>>([]);
  bool isSearching = false;

  Future<void> _extractNfcData() async {
    try {
      final String userDataJson = await readNfcTag();
      final userData = jsonDecode(userDataJson);
      userDataList.value = [userData];
    } catch (e) {
      print('Error reading NFC tag: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _extractNfcData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
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
    );
  }
}
