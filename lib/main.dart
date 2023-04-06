import 'package:flutter/material.dart';
import 'package:mastering_flutter/home_screen.dart';
import 'package:mastering_flutter/second_screen.dart';

main() {
  runApp(const App());
}

/*
  In Flutter, routes are a powerful tool for navigating between different screens or pages of an application.
  The concept of routes is based on the idea of a navigation stack, which maintains a history of the screens
  that a user has visited.

  When using routes, each screen or page is represented by a unique route, which can be pushed onto or 
  popped off of the navigation stack. The stack follows a last-in, first-out (LIFO) ordering, meaning 
  that the most recently pushed screen is at the top of the stack, and will be the first to be popped 
  off when the user presses the back button.

  There are several advantages to using routes for navigation in Dart:

    Code organization: Defining routes helps organize the application's code by separating each screen into 
    its own file and making it easier to manage the navigation between them.

    Reusability: Routes allow for the reuse of existing screens or pages, rather than creating new ones each 
    time the user navigates.

    Flexibility: Routes provide the flexibility to navigate between screens in any order, rather than just 
    sequentially.

    Maintain state: Routes allow you to maintain the state of each screen in the navigation stack, even 
    when a screen is pushed or popped.
*/

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navigation In Flutter",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const HomeScreen(),
      // when using routes we give it within the root widget, commonly just below home
      // route is a map ie we give a custom name(key) and  value, and call it from other screens
      routes: {
        'screen_1': (ctx) => HomeScreen(),
        'screen_2': (ctx) => Screen2(),
      },
    );
  }
}
