import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/db_helper.dart';
import '../models/user_model.dart';

class AuthService {
  final DBHelper _dbHelper = DBHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /*
    FirebaseAuth is a class provided by the Firebase Authentication SDK for handling user authentication.
    It provides methods for creating user accounts, signing in with email and password, signing in with 
    social identity providers such as Google and Facebook, and more. FirebaseAuth interacts with the 
    Firebase Authentication backend to manage user authentication.
  */

  // Sign up with email and password
  Future<UserModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    // A credential is a piece of information that represents a user's identity.
    // For example, an email address and password combination is a credential that can be used
    // to authenticate a user's identity.

    final UserCredential credential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    /*
      The createUserWithEmailAndPassword() method of FirebaseAuth creates a new user account associated 
      with the specified email address and password. It returns a UserCredential object, which contains 
      the User object for the newly created user.

      The UserCredential object represents the result of a sign-in or sign-up operation, which includes 
      both the authenticated user and the AuthCredential used to authenticate the user. The AuthCredential 
      is a verification method that proves a user's identity, such as an email address and password, 
      a Google account, or a Facebook account.
    */

    // Create a new user profile in Firestore
    UserModel newUser = UserModel(
      uid: credential.user!.uid,

      /*
        The uid is created automatically by Firebase when a user signs up and can be used to reference the 
        user's data in other Firebase services such as Firestore, Realtime Database, and Storage.
      */

      name: name,
      email: email,
      phoneNumber: phoneNumber,
    );
    await _dbHelper.addUser(newUser);

    return newUser;
  }

  //Log In

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      //  If the login was successful, keep the user logged in for one day
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loggedIn', true); // set the flag

      // If the login was successful, return the logged in user
      return user;
    } on FirebaseAuthException catch (e) {
      print('login failed: ${e.message}');
      return null;
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('forgot password failed: ${e.message}');
    }
  }

  // Persist Login Function and logic using Shared Preferences

  Future<bool> isLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    /*
      The SharedPreferences.getInstance() method returns a Future that completes with an instance of 
      SharedPreferences. This instance is an in-memory representation of the shared preferences file, 
      and it is not directly tied to any specific file on disk. 

      The shared preferences file itself is stored in a platform-specific location, depending on the 
      operating system: On Android, the shared preferences file is stored in the app's data directory, 
      which is usually located at /data/data/<package_name>/shared_prefs/. 
    */

    bool loggedIn = _prefs.getBool('loggedIn') ?? false;

    // Sets the value of loggedIn to the value of 'loggedIn' key if it is present in SharedPreferences
    // or false if it is not present.

    // You can use the instance _prefs to store and retrieve data using keys and values.
    // For example, you can save a boolean value using a key like "loggedIn" and a value of true or
    // false to indicate whether the user is currently logged in or not. You can then retrieve this
    // value using the same key to determine the user's login state.

    return loggedIn;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false); // set the flag to false
  }
}
