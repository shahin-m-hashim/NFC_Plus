import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';

class TodoHelper {
  static const String table = 'todos';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnIsCompleted = 'isCompleted';

/*

  In object-oriented programming, static is a keyword that is used to define class-level members, i.e., 
  members that belong to the class itself, rather than to its individual instances.

  A static member is associated with the class, rather than with any particular object created from the 
  class. This means that you can access static members without creating an instance of the class. You can
  call static methods or access static properties using the class name followed by the member name, 
  like ClassName.staticMemberName.

  In the context of the error you encountered earlier, it is because the update method is a static method, 
  which means it belongs to the class TodoHelper and not to its instances. So you cannot call the update 
  method using an instance of the TodoHelper class. You need to use the class name followed by the method 
  name, like TodoHelper.update().

  If your TodoHelper class only has static methods, then you don't need to create an instance of the class 
  to use its methods. You can call the methods directly using the class name followed by the method name, 
  like TodoHelper.update(todo).

  However, if your TodoHelper class also has non-static methods, then you will need to create an instance 
  of the class using the new keyword, or simply by calling the constructor directly like TodoHelper(), to 
  use the non-static methods.

*/

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
