import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/db_helper.dart';
import '../models/user_model.dart';

class AuthService {
  final DBHelper _dbHelper = DBHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<AdminModel?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    final UserCredential credential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Create a new user profile in Firestore
    AdminModel newUser = AdminModel(
      uid: credential.user!.uid,
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
    bool loggedIn = _prefs.getBool('loggedIn') ?? false;
    return loggedIn;
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false); // set the flag to false
  }
}
