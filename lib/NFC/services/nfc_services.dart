import 'dart:async';

import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';

/*
  The isAvailable method of the NfcManager class checks whether the device supports NFC technology or not. 
  It returns a Future that completes with a bool value, true if NFC is available on the device, and 
  false otherwise.

  This method only checks for the availability of NFC hardware on the device and does not check the 
  status of the NFC tag.
*/

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
  } on Exception catch (ex) {
    // Handle NFC exceptions
    print(ex.toString());
    completer.complete(false);
  } catch (e) {
    completer.complete(false);
  }
  bool result = await completer.future;
  return result;
}

// READ DATA IF NFC FOUND

Future<String> readNfcTag() async {
  String data = '';
  Completer<bool> completer = Completer<bool>();

  Future.delayed(const Duration(seconds: 15), () {
    if (!completer.isCompleted) {
      completer.complete(false);
    }
  });

  try {
    await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final ndef = Ndef.from(tag);
      if (ndef == null) return;
      final records = ndef.cachedMessage?.records ?? [];
      for (final record in records) {
        data = String.fromCharCodes(record.payload.sublist(3));
        break;
      }
      await NfcManager.instance.stopSession();
      completer.complete(true);
    });
  } on PlatformException catch (ex) {
    // Handle NFC exceptions
    print(ex.toString());
    completer.complete(false);
  } catch (e) {
    completer.complete(false);
    data = '';
  }
  await completer.future;
  return data;
}
