import 'package:flutter/material.dart';

import '../database/hive_functions/db_functions.dart';
import 'add_todo.dart';
import 'list_todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    get_all_todo_from_db();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AddTodo(),
            const Expanded(child: ListTodo()),
          ],
        ),
      ),
    );
  }
}
