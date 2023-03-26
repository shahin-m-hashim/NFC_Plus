import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

/*
  The above is a basic Dart code for starting a Flutter application.

  The main() function is the entry point for the Dart program. It is the first function that gets executed 
  when a Dart application starts running.

  In this code, the runApp() function is called with an argument app. The runApp() function is a built-in 
  function in Flutter that is used to start the application. It takes a widget as an argument and renders 
  it on the screen.

  So, runApp(app) is starting the application by rendering the app widget on the screen.

  In Flutter, an App is the top-level widget that represents the entire application. It provides the 
  structure and composition of all the lower-level widgets used in the app.

  An App widget can be defined by extending the StatelessWidget or StatefulWidget class. Typically, the 
  MaterialApp or CupertinoApp class is used to create an App widget.

  The MaterialApp widget is used to create apps with Material Design, while the CupertinoApp widget is used 
  to create apps with Apple's Cupertino Design.

  The MaterialApp widget has several important parameters, such as title, theme, home, routes, initialRoute, 
  navigatorKey, and more. These parameters allow you to customize the app's appearance, behavior, and navigation.

  The title parameter sets the title of the app, which is usually displayed in the app bar. The theme 
  parameter sets the color scheme, typography, and other visual aspects of the app. The home parameter 
  sets the widget that is displayed when the app is launched. The routes parameter defines a map of named 
  routes to widgets that can be used for navigation. The initialRoute parameter sets the initial route for 
  the app. The navigatorKey parameter provides a key to the Navigator widget, which is used for navigating
  between screens.

  Overall, the App widget is the foundation of a Flutter app, and the MaterialApp or CupertinoApp widget is 
  usually used to create it. These widgets provide important parameters that allow you to customize the 
  app's appearance, behavior, and navigation.

  Stateless widgets are immutable, meaning their properties can't be changed once they are constructed. 
  They are useful for displaying static content, such as text or images, or for creating simple user 
  interfaces.

  Stateful widgets, on the other hand, are mutable and can change their properties over time. They are 
  useful for creating more complex user interfaces, such as forms or animations, where the UI needs to 
  respond to user input or other events.
  
*/


