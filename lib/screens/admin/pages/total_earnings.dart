import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helpers/core_functions.dart';

class TotalEarnings extends StatefulWidget {
  const TotalEarnings({Key? key});

  @override
  _TotalEarningsState createState() => _TotalEarningsState();
}

class _TotalEarningsState extends State<TotalEarnings> {
  int? todayIncome;
  int? weeklyIncome;
  Map<String, dynamic>? monthlyIncome;

  @override
  void initState() {
    super.initState();
    getCurrentDayIncome(DateTime.now()).then((value) {
      setState(() {
        todayIncome = value;
      });
    });

    getCurrentWeekIncome(DateTime.now()).then((value) {
      setState(() {
        weeklyIncome = value;
      });
    });

    getMonthlyIncome().then((value) {
      setState(() {
        monthlyIncome = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Summary'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCard(
                title: 'Today\'s Income',
                amount: todayIncome ?? 0,
                subtitle: DateFormat('MMMM dd, yyyy').format(DateTime.now()),
                cardColor: Colors.amberAccent,
              ),
              _buildCard(
                title: 'Weekly Income',
                amount: weeklyIncome ?? 0,
                subtitle: _getWeeklySubtitle(),
                cardColor: Colors.amberAccent,
              ),
              _buildCard(
                title: 'Monthly Income',
                amount: monthlyIncome?['income'] ?? 0,
                subtitle: monthlyIncome?['month'] ?? '',
                cardColor: Colors.amberAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getWeeklySubtitle() {
    DateTime currentDate = DateTime.now();
    DateTime startOfWeek =
        currentDate.subtract(Duration(days: currentDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
    return DateFormat('MMMM dd, yyyy').format(startOfWeek) +
        ' - ' +
        DateFormat('MMMM dd, yyyy').format(endOfWeek);
  }

  Widget _buildCard({
    required String title,
    required int amount,
    String subtitle = '',
    required Color cardColor,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: cardColor,
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
            height: 2,
          ),
        ),
        trailing: Text(
          '₹$amount',
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
