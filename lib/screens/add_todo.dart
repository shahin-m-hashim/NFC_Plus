// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../database/model/todo_model.dart';
import '../sql_functions/db_functions.dart';

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

    final _todo = TodoModel(name: _name);

    add_todo_to_db(_todo);
    _namecontroller.clear(); // clear the text field after adding the new todo
  }
}
