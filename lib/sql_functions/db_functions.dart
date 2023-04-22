// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../database/model/todo_model.dart';

ValueNotifier<List<TodoModel>> todo_list_notifier = ValueNotifier([]);

late Database _db;

Future<void> OpenDB() async {
  _db = await openDatabase(
    'TodoDB',
    version: 1,
    onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE ToDo(id INTEGER PRIMARY KEY, name TEXT)');
    },
  );
}

Future<void> add_todo_to_db(TodoModel value) async {
  await _db.rawInsert('INSERT INTO ToDo (name) VALUES (?)', [value.name]);
  get_all_todo_from_db();
}

Future<void> delete_todo_from_db(int id) async {
  await _db.rawDelete('DELETE FROM ToDo WHERE id = ?', [id]);
  get_all_todo_from_db();
}

Future<void> get_all_todo_from_db() async {
  final _values = await _db.rawQuery('SELECT * FROM ToDo');
  print(_values);
  todo_list_notifier.value.clear();
  _values.forEach((map) {
    final todo = TodoModel.fromMap(map);
    todo_list_notifier.value.add(todo);
    todo_list_notifier.notifyListeners();
  });
}
