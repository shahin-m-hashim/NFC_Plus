import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'login_screen.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/*
  This is a skeletal implementation of a State object for a Flutter widget named SplashScreen. A State 
  object holds the mutable state of the corresponding StatefulWidget and rebuilds it when necessary. 
  The State object follows a lifecycle that determines when certain methods are called.

    initState() is called when the stateful widget is inserted into the widget tree for the first time. 
    This is where the initialization of the State object should be done, such as creating controllers or
    listeners.
    
    didChangeDependencies() is called immediately after initState(). This method is called when the stateful
    widget is first inserted into the widget tree and whenever the dependencies of this widget change. 
    You can use this method to handle changes to the dependencies of your widget.

    dispose() is called when the State object is removed from the widget tree permanently. It's used to 
    release resources used by the State object, such as streams, controllers, and animations.

    build() is called every time the stateful widget is redrawn, and it returns the widget to be drawn. 
    This method should be used to build the user interface of the widget. In this example, it returns a 
    blank Scaffold widget.
*/

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: Center(
          child: Image.asset(
        'assets/images/newlogo.png',
        height: 300,
        width: 300,
      )),
    );
  }

  Future<void> gotologin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => LogIn(),
      ),
    );
  }

  Future<void> checkLogin() async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    final _userlogged = _sharedPrefs.getBool(save_key_name);
    if (_userlogged == null || _userlogged == false) {
      gotologin();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx1) => HomeScreen(),
      ));
    }
  }
}
