import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  TodoModel({required this.name, this.id});
}

/*
  When you initialize Hive in your application, it creates a folder in your device's local storage called 
  the Hive box. Inside the Hive box, it creates a separate folder for each Hive type that you define in 
  your application.

  In this case, the TodoModel class is a Hive type with a type ID of 1. So, when you initialize Hive, it 
  creates a folder called todo_model inside the Hive box. 

  Inside the todo_model folder, Hive creates two files to store the data for the TodoModel objects 
/ todo_model.box and todo_model.lock. The todo_model.box file is where the actual data is stored in 
  binary format, while the todo_model.lock file is used to ensure that only one process can write to 
  the todo_model.box file at a time.

  So, you can think of the TodoModel class as a table inside the todo_model folder in the Hive box, 
  with two fields - id and name. Each instance of the TodoModel class is a row in this table, and is 
  stored in the todo_model.box file.

  When you create a new class with a @HiveType(typeId: x) annotation, it creates a new table with the 
  type id x inside the Hive box. Each table has a unique id, and you can have multiple tables 
  inside a single Hive box, each corresponding to a different class. This allows you to store 
  and retrieve different types of data in a single Hive box.

  use command - flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs

  to build the adapter without any conflicts when creating a new flutter project
  build this once and whenever models are created and saved with part specified
  the adapter gets automatically built.
*/