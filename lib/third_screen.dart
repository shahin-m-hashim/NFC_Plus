import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Third Screen',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                wordSpacing: 10,
              ),
            ),
            const SizedBox(height: 150),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('screen_1');
                  Navigator.of(context).pop(); //we mostly use pop to go back
                },
                child: const Text(
                  'Go Back',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
