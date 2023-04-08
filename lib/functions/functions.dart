import 'package:flutter/material.dart';

import '../database/model/todo.dart';

ValueNotifier<List<TodoModel>> todo_list_notifier = ValueNotifier([]);

// The angle bracket notation ValueNotifier<List<TodoModel>> specifies the type of data that todolist
// can hold, which is a List of TodoModel instances. This means that whenever a new value of type
// List<TodoModel> is assigned to todolist, all listeners that are registered with todolist are
// notified of the change.

void add_todo(TodoModel value) {
  todo_list_notifier.value.add(value);
  todo_list_notifier.notifyListeners();
}
