import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../helpers/core_functions.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  Future<int> getTodaysIncome() async {
    final currentDayIncome = await getCurrentDayIncome(DateTime.now());
    return currentDayIncome;
  }

  Future<int> getWeeksIncome() async {
    final currentWeekIncome = await getCurrentWeekIncome(DateTime.now());
    return currentWeekIncome;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 55, 53, 53),
              Color(0x88211E1E),
            ]),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          FutureBuilder<int>(
            future: getTodaysIncome(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final todaysIncome = snapshot.data!;
                return FutureBuilder<double>(
                  future: getProgressPercentage(todaysIncome.toDouble()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final progress = snapshot.data!;
                      return CircularPercentIndicator(
                        backgroundWidth: 100,
                        radius: 135.0.r,
                        animation: true,
                        animationDuration: 1500,
                        lineWidth: 20.0,
                        percent: progress,
                        reverse: false,
                        arcBackgroundColor: const Color(0xFF14bae3),
                        arcType: ArcType.FULL,
                        center: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40.h,
                            ),
                            Text(
                              '₹${todaysIncome.toString()}',
                              style: TextStyle(
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'So Far This Day',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            FutureBuilder<int>(
                              future: getWeeksIncome(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final weeksIncome = snapshot.data!;
                                  return Column(
                                    children: [
                                      Text(
                                        '₹${weeksIncome.toString()}',
                                        style: TextStyle(
                                          fontSize: 27.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Text(
                                        'This Week',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 23.h,
                                      ),
                                      Text(
                                        '₹5000/Day',
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        circularStrokeCap: CircularStrokeCap.square,
                        backgroundColor: Colors.yellow,
                        progressColor: Colors.orange,
                      );
                    }
                  },
                );
              }
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'transaction list');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0.r)),
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF6673CE),
                      Color(0xFF16b3ed),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
                  child: Center(
                    child: Text(
                      'TRANSACTIONS',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'total earnings');
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0.r)),
              child: Container(
                height: 50.h,
                width: 300.w,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                      Color.fromARGB(255, 112, 230, 89),
                      Color.fromARGB(255, 22, 237, 33),
                    ])),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
                  child: Center(
                    child: Text(
                      'TOTAL EARNINGS',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
