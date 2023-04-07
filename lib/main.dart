/*
  Shared preferences is a mechanism provided by the Android platform that allows you to store and retrieve 
  simple data in key-value pairs. This is often used for storing user preferences such as language settings,
  theme settings, or even login information. For example, once we login into instagram we wont be asked to
  login again and again even after we restart.Its because we have already stored that temporary information
  locally without any external server/database, and hence makes it easier to use apps. 

  Shared preferences are stored in an XML file in the application's private data folder. This data can be 
  accessed by other components of the same application.

  To use shared preferences in an Android application, you first need to get an instance of the 
  SharedPreferences class by calling the getSharedPreferences() method. You can then use this object 
  to store and retrieve data using the putString(), putInt(), putBoolean(), getString(), getInt(), and 
  getBoolean() methods.

*/

import 'package:flutter/material.dart';

import 'homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}
