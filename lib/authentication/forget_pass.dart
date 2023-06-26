import 'package:flutter/material.dart';
import 'services/validation.dart';

class ForgotPasswordDialog {
  static AlertDialog build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();

    return AlertDialog(
      title: const Text('Reset Password'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          validator: Validator.validateEmail,
          decoration: const InputDecoration(
            labelText: 'Enter your registered email',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, _emailController.text);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
