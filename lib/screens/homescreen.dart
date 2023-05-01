import 'package:flutter/material.dart';

import '../Firestore_fns/db_helper.dart';
import '../models/todo.dart';
import 'edit_todo_popup.dart';

class HomeScreen extends StatelessWidget {
  final ValueNotifier<List<Todo>> _todosNotifier = ValueNotifier([]);

  HomeScreen() {
    _refreshTodoList();
  }

  Future<void> _refreshTodoList() async {
    final todos = await TodoHelper.getTodos();
    _todosNotifier.value = todos;
    print('Todo list refreshed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: ValueListenableBuilder<List<Todo>>(
        valueListenable: _todosNotifier,
        builder: (context, todos, _) {
          if (todos.isEmpty) {
            return const Center(
              child: Text('No todos saved.'),
            );
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final Todo todo = todos[index];
              return ListTile(
                title: Text(todo.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        final currentName = ValueNotifier<String>(todo.name);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return EditTodoPopup(
                              id: todo.id!, // add the todo ID here
                              currentName: currentName,
                              onSave: (String id, String newName) async {
                                // add the ID parameter here
                                await TodoHelper.updateTodoById(id,
                                    newName); // pass the ID parameter here as well
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
