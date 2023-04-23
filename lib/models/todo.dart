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

  /*

    toMap() is used to convert a Todo object to a Map<String, dynamic>. This method creates a new Map object 
    with keys and values representing the id, name, and isCompleted properties of the Todo object. The 
    isCompleted property is converted to an integer (either 1 or 0) based on whether it is true or false, 
    respectively. The resulting Map can then be used to store the Todo object in a database or send it over 
    a network.

  */

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      name: map['name'],
      isCompleted: map['isCompleted'] == 1,
    );
  }

  /*

    fromMap() is used to create a Todo object from a Map<String, dynamic>. This method takes in a Map as 
    an argument and uses its values to create a new Todo object. The id and name properties are set 
    directly from the Map, while the isCompleted property is set based on the value of the isCompleted 
    key in the Map. If the value is 1, isCompleted is set to true, and if the value is 0, isCompleted 
    is set to false. The resulting Todo object can then be used in the application.

  */
}


/*

THE IMPORTANT CONVERSIONS TO USE WHEN USING SQL DATABASE IN FLUTTER

Sure, here are some examples of how to convert various data types to a map and vice versa:

String:

To Map:

  final String myString = 'Hello World';
  final Map<String, dynamic> myStringMap = {'string': myString};

From Map:

  final Map<String, dynamic> myStringMap = {'string': 'Hello World'};
  final String myString = myStringMap['string'];

Integer:

To Map:

  final int myInt = 42;
  final Map<String, dynamic> myIntMap = {'int': myInt};

From Map:

  final Map<String, dynamic> myIntMap = {'int': 42};
  final int myInt = myIntMap['int'];

Double:

To Map:

  final double myDouble = 3.14;
  final Map<String, dynamic> myDoubleMap = {'double': myDouble};

From Map:

  final Map<String, dynamic> myDoubleMap = {'double': 3.14};
  final double myDouble = myDoubleMap['double'];

List:

To Map:

  final List<String> myList = ['apple', 'banana', 'orange'];
  final Map<String, dynamic> myListMap = {'list': myList};

From Map:

  final Map<String, dynamic> myListMap = {'list': ['apple', 'banana', 'orange']};
  final List<String> myList = List<String>.from(myListMap['list']);

Set:

To Map:

  final Set<String> mySet = {'apple', 'banana', 'orange'};
  final Map<String, dynamic> mySetMap = {'set': mySet.toList()};

From Map:

  final Map<String, dynamic> mySetMap = {'set': ['apple', 'banana', 'orange']};
  final Set<String> mySet = Set<String>.from(mySetMap['set']);

Note that the above examples assume that the map keys are always strings. When using JSON, which is a 
popular format for storing data, the keys may be of any type, but they are typically strings.

*/

/*

SQL is a database management system that stores data in tables with rows and columns. Each row represents 
a single record, while each column represents a specific attribute or field of the record.

When we retrieve data from an SQL database, it is typically returned as a set of rows. However, in order
to use this data in a Flutter application, we often need to convert it to a different format, such as a 
Map or a custom model class.

The reason for this is that the data retrieved from an SQL database is typically represented as a list of 
tuples, where each tuple represents a single row of the table. This format is not well-suited for use in 
a Flutter application, where we typically work with structured data in the form of Maps or custom model 
classes.

Therefore, we need to convert the data retrieved from the SQL database to a format that is easier to work 
with in Flutter. This is typically done by mapping the tuples to Maps or custom model classes that are more 
appropriate for use in a Flutter application.

Similarly, when we want to store data in an SQL database from a Flutter application, we typically need to 
convert the data from its native format (e.g. a Map or custom model class) to a format that can be stored 
in the SQL database (e.g. a set of tuples). This conversion is typically done using a mapping function that 
maps the data from its native format to a format that can be stored in the SQL database.

*/


/*

You can use both a data model and a helper class to interact with your SQLite database. The data model 
represents the structure of your data and provides methods to convert the data to and from a format that 
can be stored in the database, while the helper class provides methods to perform CRUD (create, read, 
update, delete) operations on the database.

Typically, you would create a separate data model class for each table in your database and a helper class 
that provides methods to interact with all the tables in the database. This approach helps to keep your 
code organized and makes it easier to maintain and modify your database operations in the future.

*/