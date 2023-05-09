import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_transaction_model.dart';

class UserTransactionDBHelper {
  static const String collection = 'User Transactions';
  static const String fieldName = 'To';

  // Initialize the Firestore database collection reference
  static CollectionReference _getCollection() =>
      FirebaseFirestore.instance.collection(collection);

  // Create a reference to a specific document in the Users collection
  static DocumentReference getUserDocumentById(String id) =>
      _getCollection().doc(id);

  static Future<String> insert(UserTransactionModel userData) async {
    final collection = _getCollection();
    final docRef = await collection.add(userData.toJson());
    await docRef.set({'Document Id': docRef.id}, SetOptions(merge: true));
    return docRef.id;
  }

  static Future<List<UserTransactionModel>> getUsers() async {
    final collection = _getCollection();
    final QuerySnapshot snapshot = await collection.orderBy(fieldName).get();
    final List<UserTransactionModel> users = [];
    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      users.add(UserTransactionModel.fromJson(data));
    });
    return users;
  }

  static Future<int?> fetchAmountPaid(String transactionId) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('UserTransactions')
          .doc(transactionId)
          .get();
      if (snapshot.exists) {
        final Map<String, dynamic> data =
            snapshot.data() as Map<String, dynamic>;
        final UserTransactionModel transaction =
            UserTransactionModel.fromJson(data);
        return transaction.Amount_Paid;
      } else {
        return null; // Document with the provided transactionId does not exist
      }
    } catch (error) {
      print('Failed to fetch amount paid: $error');
      return null;
    }
  }
}
