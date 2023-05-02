import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/services/auth_services.dart';
import '../auth/services/validation.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Authentication'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: Validator.validateEmail,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: Validator.validatePassword,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: 380,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Call the AuthService login method with the email and password
                          User? user = await AuthService().login(
                              _emailController.text, _passwordController.text);

                          // User? is the return type of the user variable, which means it can either hold
                          // a User object or a null value.

                          if (user != null) {
                            // Clear the text fields
                            _emailController.clear();
                            _passwordController.clear();

                            // Navigate to the home screen if the login was successful
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            // Display a red snackbar if the login failed
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Invalid email or password'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () async {
                          _emailController.clear();
                          _passwordController.clear();
                          _formKey.currentState!.reset();
                          await Navigator.pushNamed(context, 'sign_up');
                        },
                        child: const Text('Sign up'),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Prompt user to enter email address
                          final email = await showDialog<String>(
                            context: context,
                            builder: (context) =>
                                ForgotPasswordDialog.build(context),
                          );

                          if (email != null) {
                            _formKey.currentState!.reset();
                            // Call the AuthService forgotPassword method with the email
                            await AuthService().forgotPassword(email);
                            // Show a snackbar to notify user that password reset email has been sent
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content:
                                    Text('Password reset email has been sent'),
                              ),
                            );
                          }
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
