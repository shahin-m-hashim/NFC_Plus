import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo.dart';

class TodoHelper {
  static const String collection = 'Todos';
  static const String fieldName = 'Name';

  // Initialize the Firestore database collection reference
  static CollectionReference _getCollection() =>
      FirebaseFirestore.instance.collection(collection);

  // This returns a collection named Todos

  // Create a reference to a specific document in the Todos collection
  static DocumentReference getTodoDocumentById(String id) =>
      _getCollection().doc(id);

  // This returns a specific document by its id

  /*
    A CollectionReference represents a collection of documents, and a DocumentReference represents a 
    single document within a collection.

    The above is same as Create a reference to the "todos" collection in Firestore by

    - CollectionReference todosCollection = FirebaseFirestore.instance.collection('todos');

    it can be a good approach for encapsulating the logic for accessing the collection 
    in one place. This can make the code more modular and easier to maintain, especially 
    if you have multiple functions that need to access the same collection.

    By defining a static function to return the collection reference, you can ensure that any updates 
    to the collection name or other parameters are made in one place, rather than having to update them 
    in every function that uses the collection reference. Additionally, this approach allows you to easily
    mock or stub out the collection reference during testing, which can be helpful for testing the behavior
    of your code in different scenarios.

  */

  static Future<String> insert(Todo todo) async {
    final collection = _getCollection();
    final docRef = await collection.add(todo.toMap());
    await docRef.set({'id': docRef.id}, SetOptions(merge: true));
    return docRef.id;
  }

  /*

  When adding data to a Firestore collection, the data is stored as a collection of documents, and each 
  document contains a set of key-value pairs. These key-value pairs are represented as a map in your code, 
  and Firestore SDKs automatically serialize and deserialize the maps for you. So i need to either directly
  give maps to database like

    - todosCollection.add({
        'name': 'buy pen',
        })
        .then((value) => print('Data added successfully'))
        .catchError((error) => print('Failed to add data: $error'));

      This is the direct way of adding data to our collection. 
      We can see these are map which is an unordered collection of key-value pairs.
      So when adding data dynamically we must return a map. hence we call todo.toMap()
      which returns a map
  */

  static Future<void> deleteTodoById(String id) async {
    print('Deleting todo with id: $id');
    final doc = getTodoDocumentById(id);
    await doc.delete();
  }

  static Future<void> updateTodoById(String id, String newName) async {
    final doc = getTodoDocumentById(id);
    await doc.update({fieldName: newName});
  }

  static Future<List<Todo>> getTodos() async {
    final collection = _getCollection();
    final QuerySnapshot snapshot = await collection.orderBy(fieldName).get();
    final List<Todo> todos = [];
    snapshot.docs.forEach((doc) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      todos.add(Todo.fromMap(data));
    });
    return todos;
  }
}
