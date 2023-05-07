import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/core_functions.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  _BalanceWidgetState createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 55, 53, 53),
            Color(0x88211E1E),
          ])),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 25.h,
          ),
          CircularPercentIndicator(
            backgroundWidth: 100,
            radius: 130.0.r,
            animation: true,
            animationDuration: 2000,
            lineWidth: 20.0,
            percent: getProgressPercentage(),
            reverse: false,
            arcBackgroundColor: const Color(0xFF14bae3),
            arcType: ArcType.FULL,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  '₹ ${getCurrentDayIncome()}',
                  style: TextStyle(
                    fontSize: 35.sp,
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
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                Text(
                  '₹ ${getCurrentWeekIncome()}',
                  style: TextStyle(
                    fontSize: 24.sp,
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
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  '₹1000/Day',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: Colors.yellow,
            progressColor: Colors.orange,
          ),
          SizedBox(
            height: 20.h,
          ),
          TextButton(
            onPressed: () {},
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
                    ])),
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
            onPressed: () {},
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
