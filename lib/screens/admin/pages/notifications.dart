import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../NFC/database/transaction_db_helper.dart';
import '../helpers/core_functions.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>>? notifications = [];

  @override
  void initState() {
    super.initState();
    getTotalIncome();
    getMonthlyIncome();
    TransactionDBHelper.fetchTransactionIdAndDate().then((data) {
      setState(() {
        notifications = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: _buildNotificationsList(),
    );
  }

  Widget _buildNotificationsList() {
    if (notifications == null || notifications!.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'You currently have no notifications.',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final groupedNotifications = groupNotificationsByDate();

    return ListView.builder(
      itemCount: groupedNotifications.length,
      itemBuilder: (context, index) {
        final date = groupedNotifications.keys.elementAt(index);
        final dateNotifications = groupedNotifications[date];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(
                date,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: Colors.red,
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dateNotifications!.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                color: Colors.blue,
              ),
              itemBuilder: (context, index) {
                final notification = dateNotifications[index];
                final int transactionId = notification['transactionId'];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  title: Text(
                    'Successfully added a new transaction: $transactionId',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                );
              },
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }

  Map<String, List<Map<String, dynamic>>> groupNotificationsByDate() {
    notifications!.sort((a, b) {
      final String dateA = a['transactionDate'];
      final String dateB = b['transactionDate'];
      final DateTime dateTimeA = DateFormat('MMM dd yyyy').parse(dateA);
      final DateTime dateTimeB = DateFormat('MMM dd yyyy').parse(dateB);
      return dateTimeA.compareTo(dateTimeB);
    });

    final Map<String, List<Map<String, dynamic>>> groupedNotifications = {};

    for (final notification in notifications!) {
      final String transactionDate = notification['transactionDate'];
      if (groupedNotifications.containsKey(transactionDate)) {
        groupedNotifications[transactionDate]!.add(notification);
      } else {
        groupedNotifications[transactionDate] = [notification];
      }
    }

    return groupedNotifications;
  }
}
