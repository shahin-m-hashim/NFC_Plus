import 'package:flutter/material.dart';
import 'package:mastering_flutter/second_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: SafeArea(
            child: Column(
          children: [
            const Text(
              'Home Screen',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) {
                        return const Screen2();
                      }));
                    },
                    child: const Text(
                      'Go to screen 2',
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
