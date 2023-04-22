class TodoModel {
  int? id;

  final String name;

  TodoModel({required this.name, this.id});

  static TodoModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    return TodoModel(id: id, name: name);
  }
}
