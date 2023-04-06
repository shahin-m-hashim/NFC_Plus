import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home Screen',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 150),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(
                      'screen_2'); //here we just call the name of the screen and discard homescreen
                  /*
                    pushReplacement is a method in the Flutter Navigator class that allows you to 
                    navigate to a new screen and replace the current screen in the stack with the 
                    new screen.

                    When you use pushReplacement method, it adds a new route to the stack and removes 
                    the current route from the stack, effectively replacing the current screen with the
                    new screen. This means that if you use the back button, you will not go back to the 
                    previous screen, but rather exit the app or go to the home screen of the device.
                  */
                },
                child: const Text('Go to Screen 2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
