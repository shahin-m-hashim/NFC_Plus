import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  Account({super.key});

  final _Person = [
    'person 1',
    'person 2',
    'person 3',
    'person 4',
    'person 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SizedBox(
            width: double.infinity,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.orangeAccent,
              ),
              dropdownColor: Colors.green[500],
              onChanged: (value) {},
              hint: const Text("Select Your Account"),
              items: _Person.map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ),
              ).toList(),
              /*
                  This code is creating a list of DropdownMenuItem widgets from the _Person list using 
                  the map() function.
            
                  For each element e in the _Person list, it creates a new DropdownMenuItem with a value 
                  of e and a child of Text(e).
            
                  The value property of DropdownMenuItem represents the value that is selected when the 
                  user selects this item from the dropdown list. In this case, it is set to the value of 
                  the corresponding _Person element.
            
                  The child property of DropdownMenuItem is the widget that is displayed to the user for 
                  this item in the dropdown list. In this case, it is a Text widget with the value of the 
                  corresponding _Person element.
            
                  The toList() method is called on the result of the map() function to convert the iterable 
                  into a list, which is then used as the items property of the DropdownButtonFormField.
                */
            ),
          ),
        ),
      ),
    );
  }
}
