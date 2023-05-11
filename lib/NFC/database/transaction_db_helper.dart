import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/user_transaction_model.dart';

class TransactionDBHelper {
  static const String collection = 'User Transactions';
  static const String fieldName = 'To';

  // Initialize the Firestore database collection reference
  static CollectionReference _getCollection() =>
      FirebaseFirestore.instance.collection(collection);

  // Create a reference to a specific document in the Users collection
  static DocumentReference getUserDocumentById(String id) =>
      _getCollection().doc(id);

  static Future<bool> insert(UserTransactionModel userData) async {
    try {
      final collection = _getCollection();
      final docRef = await collection.add(userData.toJson());
      await docRef.set({'Document Id': docRef.id}, SetOptions(merge: true));
      // print('User data stored in the database with document ID: ${docRef.id}');
      return true;
    } catch (error) {
      // print('Failed to store user data: $error');
      return false;
    }
  }

  static Future<List<UserTransactionModel>> fetchUserTransactions() async {
    try {
      final collection =
          FirebaseFirestore.instance.collection('User Transactions');
      final QuerySnapshot snapshot = await collection.get();

      List<UserTransactionModel> userTransactions = [];

      snapshot.docs.forEach((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final UserTransactionModel transaction =
            UserTransactionModel.fromJson(data);

        userTransactions.add(transaction);
      });

      // print(userTransactions);

      return userTransactions;
    } catch (error) {
      // print('Error fetching user transactions: $error');
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> fetchTransactionIdAndDate() async {
    try {
      final collection =
          FirebaseFirestore.instance.collection('User Transactions');
      final QuerySnapshot snapshot = await collection.get();

      List<Map<String, dynamic>> transactionDataList = [];

      snapshot.docs.forEach((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        final UserTransactionModel transaction =
            UserTransactionModel.fromJson(data);
        final int transactionId = transaction.UPI_Transaction_Id;
        final String transactionDateStr = data['Date'] as String;
        final DateTime transactionDate =
            DateFormat('MMMM dd yyyy').parse(transactionDateStr);
        final String formattedDate =
            DateFormat('MMM dd yyyy').format(transactionDate);
        final transactionData = {
          'transactionId': transactionId,
          'transactionDate': formattedDate,
        };

        transactionDataList.add(transactionData);
      });

      // print('Fetched transaction data: $transactionDataList');

      return transactionDataList;
    } catch (error) {
      // print('Error fetching transaction data: $error');
      return [];
    }
  }
}
