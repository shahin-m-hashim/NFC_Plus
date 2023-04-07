import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
/*
  A bottom sheet is a popup that slides up from the bottom of the screen to display additional content or 
  options for the user. It's commonly used to display contextual information, settings, or actions that 
  are related to the current screen.

  In Flutter, you can use the showModalBottomSheet method to display a bottom sheet. This method takes a 
  BuildContext and a builder function as arguments. The builder function returns a widget that is displayed 
  within the bottom sheet.
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Incrementer"),
      ),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            alignment: AlignmentDirectional.topCenter,
            child: FloatingActionButton(
              onPressed: () {
                showBottomSheet(context);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet(BuildContext ctx) async {
    showModalBottomSheet(
        context: ctx,
        builder: (ctx1) {
          return Container(
            width: double.infinity,
            height: 300,
            color: Colors.deepPurple[600],
            child: TextButton(
              onPressed: () {},
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(ctx1).pop();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
