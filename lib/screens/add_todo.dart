// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../database/hive_functions/db_functions.dart';
import '../database/model/todo_model.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key}) : super(key: key);

  final _namecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextFormField(
            controller: _namecontroller,
            decoration: const InputDecoration(
              hintText: "Todo Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                add_todo_button();
              },
              child: const Text(
                "Save",
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Future<void> add_todo_button() async {
    final _name = _namecontroller.text.trim();
    /*
      - This line retrieves the text value entered by the user in the text field, trims any leading or 
        trailing whitespace, and stores it in a local variable called _name.
    */

    final _todo = TodoModel(name: _name);
    /*
      - This line creates a new TodoModel object using the _name value retrieved in the previous step, and 
        stores it in a local variable called _todo. This statement is equivalent to the following code 
        (different in implementation,):

      / TodoModel _todo =new TodoModel(name: _name)

      In the case of final _todo = TodoModel(name: _name);, the TodoModel class has a constructor that 
      takes a single argument name and initializes the name instance variable of the class. So, when 
      you create a new instance of TodoModel using this constructor, you are passing the _name value 
      as the argument to the constructor.

      On the other hand, when you use TodoModel _todo =new TodoModel(name: _name), you are explicitly 
      creating a new instance of TodoModel using the constructor that takes a single argument name and 
      initializing the _name instance variable of the class with the _name value.

    */

    add_todo_to_db(_todo);
    /* 
      add_todo_to_db is a function that is being called with _todo as an argument. This 
      function is most likely defined in the db_functions.dart file and is responsible 
      for adding the _todo object to the database. 
    */
    _namecontroller.clear(); // clear the text field after adding the new todo
  }
}
