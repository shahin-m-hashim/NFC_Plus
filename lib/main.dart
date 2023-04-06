import 'package:flutter/material.dart';

main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navigation In Flutter",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      // home: Homescreen(),
    );
  }
}
