import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

// CHECK IF DEVICE SUPPORT NFC OR IS DISABLED

Future<bool> isNfcAvailable() async {
  try {
    bool nfcAvailable = await NfcManager.instance.isAvailable();
    return nfcAvailable;
  } catch (e) {
    return false;
  }
}

// WRITE DATA IF NFC FOUND

Future<bool> writeNfcTagIfAvailable(String data) async {
  Completer<bool> completer = Completer<bool>();

  Future.delayed(const Duration(seconds: 15), () {
    if (!completer.isCompleted) {
      completer.complete(false);
    }
  });

  try {
    await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final message = NdefMessage([
        NdefRecord.createText(data),
      ]);
      final ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) return;
      await ndef.write(message);
      await NfcManager.instance.stopSession();
      completer.complete(true);
    });
  } on PlatformException {
    completer.complete(false);
  } catch (e) {
    completer.complete(false);
  }
  bool result = await completer.future;
  return result;
}

// READ AND ERASE THE DATA IF NFC FOUND

Future<String> readNfcTag() async {
  String data = '';
  Completer<String> completer = Completer<String>();

  Future.delayed(const Duration(seconds: 15), () {
    if (!completer.isCompleted) {
      completer.complete('');
    }
  });

  try {
    await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      try {
        final ndef = Ndef.from(tag);
        if (ndef == null) return;
        final records = ndef.cachedMessage?.records ?? [];
        for (final record in records) {
          data = String.fromCharCodes(record.payload.sublist(3));
          break;
        }
        final emptyJson = jsonEncode({});
        final emptyRecord = NdefRecord.createText(emptyJson);
        final emptyMessage = NdefMessage([emptyRecord]);
        await ndef.write(emptyMessage);
        await NfcManager.instance.stopSession();
        completer.complete(data);
      } catch (e) {
        completer.complete('empty');
      }
    });
  } on PlatformException catch (ex) {
    // Handle NFC exceptions
    completer.complete('');
  } catch (e) {
    completer.complete('');
  }

  return completer.future;
}
