import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences _prefs;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    /*
      the SharedPreferences object is obtained asynchronously using the getInstance() method, and
      the variable is initialized with the returned value in the _loadCounter() method.
    */
    setState(() {
      _count = _prefs.getInt('counter') ?? 0;
      /*
        _prefs is an instance of the SharedPreferences class.
        getInt() is a method provided by the SharedPreferences class that allows you to get an 
        integer value associated with a specific key.
        'counter' is the key used to store the integer value we want to retrieve.
        '??' is the null coalescing operator, which returns the value on the left if it's not null, 
        or the value on the right if the left value is null. So in this case, if getInt() returns a 
        non-null value, it will be assigned to _count. If getInt() returns null, _count will be assigned
        the value 0.
      */
    });
  }

  Future<void> _incrementCounter() async {
    setState(() {
      _count++;
    });
    await _prefs.setInt('counter', _count);
  }

  Future<void> _decrementCounter() async {
    setState(() {
      _count--;
    });
    await _prefs.setInt('counter', _count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Center(
          child: Text(
            "Count $_count",
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 170,
            child: FloatingActionButton(
              onPressed: _decrementCounter,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ),
          SizedBox(
            width: 60,
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
