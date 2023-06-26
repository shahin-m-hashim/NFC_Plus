import 'package:flutter/material.dart';

import '../../../NFC/models/user_transaction_model.dart';

class TransactionDetails extends StatelessWidget {
  final UserTransactionModel transaction;

  const TransactionDetails({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'From:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              transaction.To,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(thickness: 1),
            const Text(
              'Amount Paid:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '₹${transaction.Amount_Paid}',
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(thickness: 1),
            const Text(
              'Date:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              transaction.Date,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(thickness: 1),
            const Text(
              'Time:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              transaction.Time,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(thickness: 1),
            const Text(
              'UPI Transaction ID:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              transaction.UPI_Transaction_Id.toString(),
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 5),
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
