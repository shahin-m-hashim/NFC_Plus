class Todo {
  String name;

  Todo({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      name: map['Name'],
    );
  }

  // The purpose of this function is to convert a Map object that represents a Todo item in the database
  // back to a Todo object that can be used in the app code. This is useful, for example, when retrieving
  // data from the database and displaying it in the app.
}

/*

  Firestore does allow you to work with data using native data types such as maps and objects, as you 
  mentioned. This means that you can store and retrieve data using objects that are already in the correct 
  format, and you don't have to worry about serializing and deserializing them manually.

  However, when you use a custom data model like the Todo class in the example I provided, you still need 
  to perform some conversion between the native data types and your custom data model. For example, you 
  need to convert a Todo object into a map before you can store it in Firestore, and you need to convert
  a Firestore document into a Todo object before you can work with it in your Flutter code.

  In Firebase Cloud Firestore, data is stored in a NoSQL document-oriented database, which means that the 
  data is stored as documents and collections. Each document can contain multiple fields, and each field 
  can contain a variety of data types, including strings, numbers, and even nested objects.

  When you store data in Firestore, you don't need to manually convert your data into maps or key-value 
  pairs. Instead, you can directly store your data as a map, which represents a single document in a 
  collection.

  Similarly, when you retrieve data from Firestore, it is returned as a map, which you can then convert 
  back into your desired data format. Firestore also supports querying the data based on various conditions,
  such as equality, range, and even geographic location.

*/

/*

    toMap() is used to convert a Todo object to a Map<String, dynamic>. This method creates a new Map object 
    with keys and values representing the id, name, and isCompleted properties of the Todo object. The 
    isCompleted property is converted to an integer (either 1 or 0) based on whether it is true or false, 
    respectively. The resulting Map can then be used to store the Todo object in a database or send it over 
    a network.

  */

/*

    toJson() method converts the Todo object to a Map<String, dynamic> by directly returning a Map object 
    with keys and values representing the id, name, and isCompleted properties of the Todo object. 
    The resulting Map can then be used to store the Todo object in Firestore.

  */

/*

THE IMPORTANT CONVERSIONS TO USE WHEN USING FIRESTORE DATABASE IN FLUTTER

To convert various data types to JSON and vice versa, you can use the dart:
convert library which provides two classes: JsonEncoder and JsonDecoder.

Here are some examples of how to convert various data types to JSON and vice versa:

make sure to - import 'dart:convert';

String:

To Json:

  final String myString = 'Hello World';
  final String myStringJson = jsonEncode(myString);

From Json:

  final String myStringJson = '"Hello World"';
  final String myString = jsonDecode(myStringJson);

Integer:

To Json:

  final int myInt = 42;
  final String myIntJson = jsonEncode(myInt);

From Json:

  final String myIntJson = '42';
  final int myInt = jsonDecode(myIntJson);

Double:

To Json:

  final double myDouble = 3.14;
  final String myDoubleJson = jsonEncode(myDouble);

From Json:

  final String myDoubleJson = '3.14';
  final double myDouble = jsonDecode(myDoubleJson);

List:

To Json:

  final List<String> myList = ['apple', 'banana', 'orange'];
  final String myListJson = jsonEncode(myList);

From Json:

  final String myListJson = '["apple", "banana", "orange"]';
  final List<String> myList = List<String>.from(jsonDecode(myListJson));


Set:

To Json:

  final Set<String> mySet = {'apple', 'banana', 'orange'};
  final String mySetJson = jsonEncode(mySet.toList());

From Json:

  final String mySetJson = '["apple", "banana", "orange"]';
  final Set<String> mySet = Set<String>.from(jsonDecode(mySetJson));

Map:

To Json:

  final Map<String, dynamic> myMap = {'name': 'John Doe', 'age': 30};
  final String jsonString = json.encode(myMap);

From Json:

  final String jsonString = '{"name": "John Doe", "age": 30}';
  final Map<String, dynamic> myMap = json.decode(jsonString);

*/

/*

Firestore is a cloud-based NoSQL document database that is part of the Firebase platform. It is designed 
to provide real-time syncing and scalability for web, mobile, and IoT applications. Firestore stores data 
in the form of collections and documents, which are similar to tables and rows in a traditional SQL 
database. However, unlike SQL databases, Firestore is schemaless, which means you don't have to define 
a fixed schema before you start storing data. This makes it easier to store and retrieve data of different 
types and structures.

Firestore uses a flexible data model that allows you to store data in nested objects and arrays. Each 
document in a Firestore collection can contain multiple fields, which can be of different data types 
such as strings, numbers, booleans, arrays, and even nested objects. Documents are identified by a unique 
ID and can be easily queried and updated using Firestore APIs.

Firestore also provides real-time updates, which means that any changes made to a document are automatically
synced across all connected devices in real-time. This makes it ideal for building real-time applications 
such as chat apps, collaborative editing tools, and social media platforms.

In addition to its core database features, Firestore also offers integration with other Firebase services 
such as Firebase Authentication, Cloud Functions, Cloud Messaging, and Hosting. This allows developers to 
build end-to-end solutions without having to worry about backend infrastructure.

Overall, Firestore provides a powerful and flexible way to store and sync data for web, mobile, and IoT 
applications. Its flexible data model, real-time updates, and seamless integration with other Firebase 
services make it a popular choice among developers.

You can use both a data model and a helper class to interact with your SQLite database. The data model 
represents the structure of your data and provides methods to convert the data to and from a format that 
can be stored in the database, while the helper class provides methods to perform CRUD (create, read, 
update, delete) operations on the database.

Typically, you would create a separate data model class for each table in your database and a helper class 
that provides methods to interact with all the tables in the database. This approach helps to keep your 
code organized and makes it easier to maintain and modify your database operations in the future.

*/
