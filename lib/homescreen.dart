import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
/*
  ValueNotifier is a simple class provided by Flutter that can be used to hold a single value and notify 
  any listeners whenever the value changes. It is a lightweight and efficient way to manage and propagate 
  changes to a single value across the app.

  The main advantages of using ValueNotifier over StatefulWidget are:

    Simplicity: ValueNotifier is much simpler to use than StatefulWidget. It requires less code to set up 
    and manage, and it is easier to understand what it does.

    Performance: Since ValueNotifier is designed to handle only one value, it is much more efficient than 
    StatefulWidget, which can hold multiple values and requires more resources to manage them.

    Flexibility: ValueNotifier can be used in a variety of contexts and is not tied to the widget tree. It 
    can be used to manage state in any part of the app, and it can be combined with other Flutter APIs to 
    create powerful reactive UIs.

    Predictability: ValueNotifier provides a clear and simple mechanism for handling changes to a single 
    value. This makes it easier to reason about the app's behavior and easier to debug issues related to 
    state management.

    Overall, ValueNotifier is a powerful tool for managing state in Flutter apps, and it is a good 
    alternative to StatefulWidget in many cases.
*/

  ValueNotifier<int> _counter = ValueNotifier(0);

  void _incrementCounter() {
    _counter.value++;
  }

  void _decrementCounter() {
    _counter.value--;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Incrementer"),
      ),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: _counter,
            builder: (BuildContext context, int new_value, Widget? child) {
              return Text(
                "Count $new_value",
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 150,
            child: FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ),
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
