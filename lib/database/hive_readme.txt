In Flutter, there are several local database options available, including Hive, SQLite, 
and Moor.

Local databases are a useful tool for storing data locally on a device, and they offer 
several benefits over cloud databases:

    Offline Support: Local databases allow users to access data even when there is no 
    internet connection. This is especially useful for mobile applications, where internet
    connectivity can be spotty.

    Faster Performance: Since data is stored locally, accessing it is much faster than 
    retrieving data from a remote server.

    Privacy: Storing data locally on a device is more private than storing it in the 
    cloud, where it is subject to potential security breaches.

    Lower Cost: Storing data locally is often less expensive than storing it in the cloud,
    especially for smaller applications.

Hive is a popular local database option for Flutter. It is a lightweight and fast 
key-value database that is easy to use and integrates well with Flutter's reactive 
programming model. With Hive, you can store data in a simple and structured manner 
and easily retrieve it later. Additionally, Hive supports several data types, 
including integers, doubles, booleans, and lists.

Local Database Vs Shared Preferences -

Local databases like Hive are useful in scenarios where the amount of data to be stored is too 
large or too complex to be stored efficiently in SharedPreferences. 

SharedPreferences is suitable for small, simple key-value pairs, but as the size and complexity of the 
data grows it becomes more difficult and inefficient to store and retrieve the data using SharedPreferences.


How Hive Works - 

In Hive, a box is a container that holds data of the same type. Each box has a unique 
name, and you can create multiple boxes with different names. For example, you can 
create a box named "todos" to hold data about your to-do list items, and another box 
named "users" to hold user data.

When you create a box, Hive will create a file on the device's local storage to store the 
data. The data is stored in a binary format that is optimized for fast reads and writes.

Hive uses lazy loading to load data from the local storage. When you access a box for the 
first time, Hive will load the data from the file into memory. Subsequent accesses to the 
box will be much faster since the data is already in memory.

When you make changes to the data in a box, Hive writes the changes to the file on the 
device's local storage. Hive uses a write-ahead log to ensure that data is not lost in 
case of a crash or power failure.

Overall, Hive is a fast and efficient way to store data locally in Flutter apps. It 
provides a simple and easy-to-use API for performing CRUD operations on data, and it 
is optimized for performance and reliability.





Key Steps To using Hive -
1. Add hive dependencies 
2. Setup and Initialize Hive in main()
3. Create Hive Model
4. Register Hive Adapter
5. Create Hive boxes
6. Perform CRUD(Create,Read,Update,Delete)
7. Connect UI To Hive Box


How To Use Hive -

1. Add the hive and hive_flutter packages to your pubspec.yaml file:

    dependencies:
        hive: ^2.0.4
        hive_flutter: ^1.1.0

2.  Initialize Hive in the main() method of your application by calling the await Hive.initFlutter() 
    method at the beginning of your app inside the main method:

    void main() async {
        WidgetsFlutterBinding.ensureInitialized(); // WidgetsFlutterBinding.ensureInitialized() is a 
        static method that initializes the bindings required by the Flutter framework. It ensures that 
        the Flutter engine has been successfully initialized before executing any code, like creating the 
        root widget.This method must be called before invoking runApp() to create a Flutter app.
        
        await Hive.initFlutter(); //hive initialization
        // add your Hive boxes here

        runApp(const MyApp());
        }

3.  Define a model class that represents the data you want to store: 

    create a model folder within lib and add model file that consits data(values)
    that i need to persist/store in there

    import 'package:hive/hive.dart';

    part 'todo.g.dart';

    @HiveType(typeId: 0)
    class Todo extends HiveObject {
    @HiveField(0)
    String name;

    Todo({required this.name});
    }

    Generate a Hive adapter for the Todo class by running the command 
    - flutter packages pub run build_runner build 
    in your terminal. This generates a todo.g.dart file containing the adapter.

4.  Register a Hive adapter for the model class you want to store in the database using 
    Hive.registerAdapter(adapter) method. An adapter is responsible for converting the model object into 
    bytes and vice versa.

dart

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  runApp(const MyApp());
}

5.  Create a Hive boxes and use CRUD operations

    In Hive, CRUD stands for Create, Read, Update, and Delete operations. These operations are used 
    to manipulate data within a box. Here's a brief overview of each operation:

    Create (or Insert): This operation is used to create a new record in a Hive box. You can use the put 
    method to insert new data into a box.
        - box.put(key, value);

    For example, let's say you have a Hive box called todoBox with a schema that includes a name field. 
    You can insert a new record with the following code:

    // First, open the Hive box
    final box = await Hive.openBox('todoBox');

    // Insert a new record
    final todo = {'name': 'Buy groceries'};
    await box.put(1, todo);

    Read (or Select): This operation is used to read data from a Hive box. You can use the get method to 
    retrieve data from a box. Hive also provides the values method to retrieve all values in a box.
        - var data = box.get(key, {defaultValue});

        // Assuming you have a box named 'myBox' and a key named 'myKey'

        var myBox = Hive.box('myBox');
        var myData = myBox.get('myKey', defaultValue: 'No data found');

        print(myData);

    OR 
        You can also retrieve all the data in a box using the values property:
            - final data = box.values.toList();

        // Open the box
        final box = await Hive.openBox('myBox');

        // Retrieve data by its key
        final data = box.get('key');

        // Check if data is not null before using it
        if (data != null) {
        // Do something with the data
        }

    Update: This operation is used to update an existing record in a Hive box. You can use the put method 
    to update data in a box. If the record doesn't exist, the put method will create a new record.
        - await box.put(key, value);
    
    Where key is the unique identifier of the record and value is the updated value.

    For example, to update a record with key "1" and set its value to "new value", you can use 
    the following code:

    await box.put("1", "new value");


    Delete: This operation is used to delete a record from a Hive box. You can use the delete method to 
    remove data from a box. Hive also provides the clear method to remove all data from a box.
    To delete a record from a Hive box, you can use the delete method. Here's an example:

    // Open a Hive box
    final box = await Hive.openBox('myBox');

    // Delete a record
    box.delete(key);

Final Step- Connect UI To hive Box

to connect UI to Hive, you can use ValueListenableBuilder. ValueListenableBuilder is a widget that listens to a ValueListenable and rebuilds the UI whenever the value changes. Here's an example of how to use ValueListenableBuilder with a Hive box:

    First, open the Hive box:

        Box<Todo> todoBox = Hive.box<Todo>('todos');

    Then, create a ValueNotifier that listens to the todoBox:

        ValueNotifier<List<Todo>> todoList = ValueNotifier(todoBox.values.toList());

Wrap your UI with a ValueListenableBuilder and pass the todoList as the valueListenable:

        ValueListenableBuilder(
        valueListenable: todoList,
        builder: (BuildContext context, List<Todo> todos, Widget? child) {
            // Your UI code goes here
        },
        )

Whenever you want to update the UI based on changes to the todoBox, call the following code to update the todoList:

todoList.value = todoBox.values.toList();

This will trigger a rebuild of the UI with the updated data from the Hive box.