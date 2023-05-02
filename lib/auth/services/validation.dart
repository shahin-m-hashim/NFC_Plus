import 'package:email_validator/email_validator.dart';

/*

  When you call the function specified by the validator property of a TextFormField, it expects the function
  to return a String if the input is invalid, or null if the input is valid.

  If the function returns a non-null String, it means that the input is invalid, and the TextFormField 
  will display an error message with that string as the error text.

  If the function returns null, it means that the input is valid, and the TextFormField will not display 
  an error message.

  The TextFormField will automatically update its appearance based on whether or not there is an error 
  message to display.

  Also the validator function takes a single argument, which is the value of the TextFormField being 
  validated. The validator property will automatically pass the current value of the field to the 
  function, so you don't need to explicitly provide an argument when setting the validator. 
  The validator function will return an error message if the input is invalid, and null if the input 
  is valid. The TextFormField will then update its visual appearance based on whether the input is 
  valid or not.

*/

class Validator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    final RegExp nameExp = RegExp(r'^[a-zA-Z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Invalid name';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }
    final phoneRegex = RegExp(r'^\+?\d{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be atleast 6 characters';
    }
    return null;
  }
}
