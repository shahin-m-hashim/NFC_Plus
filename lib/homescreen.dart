import 'package:flutter/material.dart';

import 'account.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
/*
  BottomNavigationBar is a widget in Flutter that displays a horizontal row of buttons at the bottom of the 
  screen, typically used for navigation between different views or screens in an app.

  It is typically used when the app has three to five main destinations. Each destination is represented by 
  a single icon and label, and the selected destination is highlighted with a different color. When the user
  taps on a destination, the app navigates to the corresponding screen.

  The BottomNavigationBar widget takes a list of BottomNavigationBarItem objects as input. Each item contains 
  an icon, a label, and an optional activeColor property to specify the color of the selected item.
*/

  int _current_index = 0;
  final _pages = [
    Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('This is the home screen'),
      ),
    ), // dummy home screen
    const Account(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_current_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current_index,
        onTap: (newIndex) {
          setState(() {
            _current_index = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Person'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}
