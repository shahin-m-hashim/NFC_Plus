import 'package:flutter/material.dart';
import 'package:mastering_flutter/home_screen.dart';

main() {
  runApp(const App());
}

/*
  In Dart, navigation is managed through a stack-like structure known as the Navigator widget. This widget 
  maintains a history of screens or "routes" that the user has visited within the app.

  When the user navigates to a new screen, the Navigator pushes that screen onto the top of the stack. This 
  is done using the Navigator.push() method, which takes a BuildContext and a new Route as arguments.

  To return to the previous screen, the user can either press the back button on their device or a button 
  within the app. When this happens, the Navigator pops the top screen off the stack and returns the user 
  to the previous screen. This is done using the Navigator.pop() method, which also takes a BuildContext 
  as an argument.

  It's worth noting that the Navigator widget only manages the navigation stack and does not dictate how 
  the screens are built or displayed. This is the responsibility of the individual screens or routes 
  themselves, which can be built using any combination of widgets and layouts.
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
    );
  }
}
