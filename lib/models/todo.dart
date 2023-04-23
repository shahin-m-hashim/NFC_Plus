class Todo {
  int? id;
  String name;
  bool isCompleted;

  Todo({
    this.id,
    required this.name,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      name: map['name'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

/*

You can use both a data model and a helper class to interact with your SQLite database. The data model 
represents the structure of your data and provides methods to convert the data to and from a format that 
can be stored in the database, while the helper class provides methods to perform CRUD (create, read, 
update, delete) operations on the database.

Typically, you would create a separate data model class for each table in your database and a helper class 
that provides methods to interact with all the tables in the database. This approach helps to keep your 
code organized and makes it easier to maintain and modify your database operations in the future.

*/