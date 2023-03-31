import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
  The below is a basic Dart code for starting a Flutter application.

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
  interfaces. If theres no change in the state fo widget we use stateless. For eg: if we want to simply display
  some data, we can use stateless.

  Stateful widgets, on the other hand, are mutable and can change their properties over time. They are 
  useful for creating more complex user interfaces, such as forms or animations, where the UI needs to 
  respond to user input or other events. If theres change in the widget like color,data,animations,tick
  mark etc we use stateful.
  
*/

main() {
  runApp(MyApp());
}

//the following is the root class(similar to head in HTML and includes metadata for the app)
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 10, 84, 234),
      ),
      home: Homescreen(), //here we specify our home screen class
    );
  }
}

/*
  There are several widgets that can be used as a home screen in Flutter, depending on the design and 
  functionality you want to achieve. Some of the commonly used widgets as a home screen are:

    Scaffold: Scaffold is a basic material design layout structure widget that provides an app bar, a
    bottom navigation bar, a floating action button, and a body area. You can use this widget to create 
    a basic home screen layout.

    Container: Container is a widget that allows you to create a custom layout by specifying its child 
    widget and decoration properties like padding, margin, background color, border, etc. You can use this
    widget to create a simple and custom home screen.

    Column: Column is a widget that arranges its child widgets in a vertical line. You can use this widget 
    to create a home screen layout with multiple widgets stacked vertically.

    ListView: ListView is a widget that allows you to create a scrollable list of child widgets. You can 
    use this widget to create a home screen with a list of items that can be scrolled up and down.

    GridView: GridView is a widget that allows you to create a scrollable grid of child widgets. You can use
    this widget to create a home screen with a grid of items that can be scrolled in both directions.

  These are just a few examples of the widgets that can be used as a home screen in Flutter. Ultimately, 
  the best widget to use depends on the design and functionality requirements of your app.
*/

// Homescreen
class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  color: Colors.yellow,
                  child: Text('Cashless Payment System',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: Text('Cashless Payment System',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.teal,
                  child: Text('Cashless Payment System',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.oswald(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              )
            ],
          ),
        ));
  }
}

// In this example, we have defined a Homescreen class that extends the StatelessWidget class. This class 
// represents the homescreen in our app and contains all the UI elements and logic for that screen.

// We have also defined a build method that returns a Scaffold widget with an AppBar and a Center widget 
// that displays some text. Finally, we have imported this class into our main file(by calling 
// home:Homescreen() and used it to create and display the screen:

