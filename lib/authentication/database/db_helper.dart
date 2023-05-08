import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class DBHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(AdminModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
      });
    } catch (e) {
      print('Error adding user to Firestore: $e');
      rethrow;
    }
  }
}
