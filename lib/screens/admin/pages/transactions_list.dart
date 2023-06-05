import 'package:flutter/material.dart';

import '../../../NFC/database/transaction_db_helper.dart';
import '../../../NFC/models/user_transaction_model.dart';
import 'transactions_details.dart';

class TransactionList extends StatelessWidget {
  final ValueNotifier<List<UserTransactionModel>> transactionsNotifier =
      ValueNotifier<List<UserTransactionModel>>([]);

  TransactionList({Key? key}) {
    TransactionDBHelper.fetchUserTransactions().then((transactions) {
      transactions.sort(
          (a, b) => b.Date.compareTo(a.Date)); // Sort transactions by date
      transactionsNotifier.value = transactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final transactions =
              await TransactionDBHelper.fetchUserTransactions();
          transactions.sort(
              (a, b) => b.Date.compareTo(a.Date)); // Sort transactions by date
          transactionsNotifier.value = transactions;
        },
        child: ValueListenableBuilder<List<UserTransactionModel>>(
            valueListenable: transactionsNotifier,
            builder: (context, transactions, child) {
              if (transactions.isEmpty) {
                return const Center(
                  child: Text(
                    'Currently You Have No Transactions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                );
              }
              return ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.amber,
                  thickness: 1.0,
                ),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TransactionDetails(transaction: transaction),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 48,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.To,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '₹${transaction.Amount_Paid}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                transaction.Time,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.red[600],
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                transaction.Date,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
