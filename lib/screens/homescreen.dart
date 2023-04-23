import 'package:flutter/material.dart';

import '../SQL_functions/db_helper.dart';
import '../models/todo.dart';
import 'edit_todo_popup.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TodoHelper _todoHelper;
  late List<Todo> _todos;

  @override
  void initState() {
    super.initState();
    _todoHelper = TodoHelper();
    _todos = [];
    _refreshTodoList();
  }

  Future<void> _refreshTodoList() async {
    List<Todo> todos = await TodoHelper.getTodos();
    setState(() {
      _todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: _todos.isEmpty
          ? const Center(
              child: Text('No todos saved.'),
            )
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (BuildContext context, int index) {
                final Todo todo = _todos[index];
                return ListTile(
                  title: Text(todo.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return EditTodoPopup(
                                currentName: todo.name,
                                onSave: (newName) async {
                                  // Here, you would update the todo with the new name
                                  todo.name = newName;
                                  await TodoHelper.update(todo);
                                  // Refresh the todo list after updating
                                  await _refreshTodoList();
                                },
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await TodoHelper.deleteTodoById(todo.id!);
                          await _refreshTodoList();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add_todo');
          await _refreshTodoList();
        },
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
