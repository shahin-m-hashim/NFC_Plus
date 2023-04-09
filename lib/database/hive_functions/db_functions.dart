// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/todo_model.dart';

ValueNotifier<List<TodoModel>> todo_list_notifier = ValueNotifier([]);

Future<void> add_todo_to_db(TodoModel value) async {
  final Todo_DB = await Hive.openBox<TodoModel>('todo_db');
  //it opens a database within TodoModel
  final _id = await Todo_DB.add(value);
  value.id = _id;

  todo_list_notifier.value.add(value);
  todo_list_notifier.notifyListeners();
  //notifies the listeners when data is added
}

Future<void> delete_todo_from_db(int id) async {
  final Todo_DB = await Hive.openBox<TodoModel>('todo_db');
  await Todo_DB.deleteAt(id);
  get_all_todo_from_db(); //notifies the listeners about updating
}

Future<void> get_all_todo_from_db() async {
  final Todo_DB = await Hive.openBox<TodoModel>('todo_db');
  todo_list_notifier.value.clear();

  todo_list_notifier.value.addAll(Todo_DB.values);
  todo_list_notifier.notifyListeners(); //notifies the listeners about updating
}
