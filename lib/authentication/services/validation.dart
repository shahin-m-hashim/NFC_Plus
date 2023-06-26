import 'package:email_validator/email_validator.dart';

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
    final phoneRegex = RegExp(r'^\+?\d{9,}$');
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
      return 'Password must be at least 6 characters';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Need at least one uppercase letter';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Need at least one special symbol';
    }
    return null;
  }
}
