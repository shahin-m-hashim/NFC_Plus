import 'package:flutter/material.dart';

import '../SQL_functions/db_helper.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Todo Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Add Todo'),
              onPressed: () async {
                final Todo newTodo = Todo(name: _textEditingController.text);
                await TodoHelper.insert(newTodo);
                _textEditingController.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Todo added successfully.'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
