import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'main.dart';

class LogIn extends StatelessWidget {
  LogIn({Key? key}) : super(key: key);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: SizedBox(
                    height: 50,
                    width: 370,
                    child: ElevatedButton(
                        onPressed: () => checkLogin(context),
                        child: const Text(
                          'LOGIN',
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin(BuildContext ctx) async {
    final _username = _usernameController.text;
    final _password = _passwordController.text;
    if (_username == _password) {
      final _sharedPrefs = await SharedPreferences.getInstance();
      await _sharedPrefs.setBool(save_key_name, true);

      Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => const HomeScreen(),
        ),
      );
    } else {
      final errormessage = "Username and Password Doesn't match";

      // Show SnackBar
      /*
        A Snackbar is a widget in Flutter that provides a brief message at the bottom of the screen, usually
        in response to a user's action. It's often used to provide feedback or to inform the user of a 
        completed task or an error. Snackbars can be customized with different colors, icons, and animation
        effects, and can be dismissed by the user by tapping on a button or by swiping them away.
      */
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(errormessage),
        ),
      );

      // Show AlertDialog
      /*
        An AlertDialog is a dialog box that displays a title and a list of actions. It is used to prompt 
        users to make a decision or display important information. The dialog box appears in front of the 
        current screen, making it a good way to interrupt the user's current task and get their attention.

        An AlertDialog typically consists of a title, a message, and one or more action buttons. The title 
        and message are displayed at the top of the dialog box, and the action buttons are displayed at the 
        bottom. The user can click one of the action buttons to dismiss the dialog box and take an action.

        In Flutter, you can create an AlertDialog widget by using the AlertDialog class. You can customize 
        the dialog by setting the title, content, and actions properties. You can also set the shape, 
        background color, and other visual properties of the dialog.
      */
      showDialog(
        context: ctx,
        builder: (ctx1) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(errormessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx1),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }
}
