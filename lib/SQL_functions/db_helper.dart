import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class TodoHelper {
  static const String table = 'todos';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnIsCompleted = 'isCompleted';

  static Future<Database> _open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todos.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT,
            $columnIsCompleted INTEGER
          )
        ''');
    });
  }

  static Future<int> insert(Todo todo) async {
    final db = await _open();
    final id = await db.insert(table, todo.toMap());
    print('Inserted new todo with id: $id');
    await db.close(); // close the database when we're done with it
    return id;
  }

  static Future<int> update(Todo todo) async {
    final db = await _open();
    final rowsAffected = await db.update(table, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
    await db.close();
    return rowsAffected;
  }

  static Future<int> deleteTodoById(int id) async {
    final db = await _open();
    final rowsAffected =
        await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
    print('Deleted $rowsAffected row(s) with id: $id');
    await db.close();
    return rowsAffected;
  }

  static Future<List<Todo>> getTodos() async {
    final db = await _open();
    final List<Map<String, dynamic>> maps = await db.query(table);
    await db.close();
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }
}
