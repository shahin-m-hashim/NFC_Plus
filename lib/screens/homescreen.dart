import 'package:flutter/material.dart';

import '../SQL_functions/db_helper.dart';
import '../models/todo.dart';
import 'edit_todo_popup.dart';

class HomeScreen extends StatelessWidget {
  // final TodoHelper _todoHelper = TodoHelper(); not needed since all functions in class are static

  final ValueNotifier<List<Todo>> _todosNotifier = ValueNotifier([]);
  // This line of code is declaring and initializing a ValueNotifier object named _todosNotifier
  // with an empty List of Todo objects.

  HomeScreen() {
    _refreshTodoList();
  }

  Future<void> _refreshTodoList() async {
    final todos = await TodoHelper.getTodos();
    _todosNotifier.value = todos;
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
              // _todos is a List of Todo objects. The line of code final Todo todo = todos[index];
              // retrieves the Todo object at the specified index in the list, and assigns it to the
              // variable todo. This allows us to access the properties of the Todo object and display
              // them in the UI.

              /*

                In the first statement, final todo = todos[index];, the type of the variable todo is 
                inferred by Dart based on the type of the element at the given index in the todos list. 
                This is called type inference, and it can be useful to write concise code.

                In the second statement, final Todo todo = todos[index];, the type of the variable todo is 
                explicitly declared to be Todo. This can be useful in situations where type safety is 
                important, or when the type of the element in the list may not be clear.

                So, both statements are valid, but the second one is more explicit about the type of the 
                variable, which can be helpful for readability and maintainability.
              */

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
                              currentName: currentName,
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
