import 'dart:async';

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
  } on PlatformException catch (ex) {
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
