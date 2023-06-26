import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../../../NFC/models/user_transaction_model.dart';

Future<double> getProgressPercentage(income) async {
  double dailyIncomeLimit = 5000.0; // Set your daily income limit here
  double currentDayIncome = income;
  double progress = currentDayIncome / dailyIncomeLimit;
  return progress.clamp(0.0, 1.0); // Limit the progress between 0.0 and 1.0
}

Future<int> getCurrentDayIncome(DateTime date) async {
  try {
    final formattedDate = DateFormat('MMMM dd yyyy').format(date);
    final collection =
        FirebaseFirestore.instance.collection('User Transactions');
    final QuerySnapshot snapshot =
        await collection.where('Date', isEqualTo: formattedDate).get();
    int totalAmount = 0;
    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final UserTransactionModel transaction =
          UserTransactionModel.fromJson(data);
      totalAmount += transaction.Amount_Paid;
    });
    return totalAmount;
  } catch (error) {
    return 0;
  }
}

Future<int> getCurrentWeekIncome(DateTime date) async {
  int totalAmount = 0;
  try {
    // Calculate the start and end dates of the week
    DateTime startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    final DateFormat formatter = DateFormat('MMMM dd yyyy');
    final String startFormattedDate = formatter.format(startOfWeek);
    final String endFormattedDate = formatter.format(endOfWeek);

    final collection =
        FirebaseFirestore.instance.collection('User Transactions');
    final QuerySnapshot snapshot = await collection
        .where('Date', isGreaterThanOrEqualTo: startFormattedDate)
        .where('Date', isLessThanOrEqualTo: endFormattedDate)
        .get();

    // print("s $startFormattedDate");
    // print("e $endFormattedDate");

    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final UserTransactionModel transaction =
          UserTransactionModel.fromJson(data);
      totalAmount += transaction.Amount_Paid;
    });
    return totalAmount;
  } catch (error) {
    return 0;
  }
}

Future<int> getTotalIncome() async {
  try {
    final collection =
        FirebaseFirestore.instance.collection('User Transactions');
    final QuerySnapshot snapshot = await collection.get();
    int totalAmount = 0;
    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final UserTransactionModel transaction =
          UserTransactionModel.fromJson(data);
      totalAmount += transaction.Amount_Paid;
    });
    print("Total: $totalAmount");
    return totalAmount;
  } catch (error) {
    return 0;
  }
}

Future<Map<String, dynamic>> getMonthlyIncome() async {
  int monthlyIncome = 0;
  DateTime currentDate = DateTime.now();
  DateTime startOfMonth = DateTime(currentDate.year, currentDate.month, 1);
  DateTime endOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);
  try {
    final DateFormat formatter = DateFormat('MMMM dd yyyy');
    final String startFormattedDate = formatter.format(startOfMonth);
    final String endFormattedDate = formatter.format(endOfMonth);

    final collection =
        FirebaseFirestore.instance.collection('User Transactions');
    final QuerySnapshot snapshot = await collection
        .where('Date', isGreaterThanOrEqualTo: startFormattedDate)
        .where('Date', isLessThanOrEqualTo: endFormattedDate)
        .get();

    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final UserTransactionModel transaction =
          UserTransactionModel.fromJson(data);
      monthlyIncome += transaction.Amount_Paid;
    });

    final String monthName = DateFormat('MMMM').format(currentDate);
    final Map<String, dynamic> result = {
      'month': monthName,
      'income': monthlyIncome,
    };
    print("Monthly Income ${result['month']}: ${result['income']}");
    return result;
  } catch (error) {
    return {
      'month': '',
      'income': 0,
    };
  }
}
