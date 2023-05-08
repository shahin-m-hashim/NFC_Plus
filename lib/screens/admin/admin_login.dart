import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/forget_pass.dart';
import '../../authentication/services/auth_services.dart';
import '../../authentication/services/validation.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  // Text editing controllers for the email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Whether to show the password or not
  bool _obscureText = true;

  // Whether the email or password fields are in error
  bool _emailError = false;
  bool _passwordError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _resetFields() {
    FocusScope.of(context).unfocus();
    _emailError = false;
    _passwordError = false;
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _obscureText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, top: 50, right: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Container(
                          margin: const EdgeInsets.only(top: 60),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Welcome\nBack',
                            style: TextStyle(color: Colors.white, fontSize: 33),
                          ),
                        ),
                        const SizedBox(height: 100),
                        const Text(
                          'Log in',
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            // decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Email",
                            errorText: _emailError
                                ? Validator.validateEmail(_emailController.text)
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _emailError =
                                  Validator.validateEmail(value) != null;
                            });
                          },
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _passwordController,
                          style: const TextStyle(),
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            errorText: _passwordError
                                ? Validator.validatePassword(
                                    _passwordController.text)
                                : null,
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _passwordError =
                                  Validator.validatePassword(value) != null;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () async {
                                // Prompt user to enter email address
                                final email = await showDialog<String>(
                                  context: context,
                                  builder: (context) =>
                                      ForgotPasswordDialog.build(context),
                                );

                                if (email != null) {
                                  // Call the AuthService forgotPassword method with the email
                                  await AuthService().forgotPassword(email);
                                  // Show a snackbar to notify user that password reset email has been sent
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                          'Password reset email has been sent'),
                                    ),
                                  );
                                }
                              },
                              child: const Text('Forgot Password?'),
                            ),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Color.fromARGB(255, 46, 91, 214),
                              child: IconButton(
                                onPressed: () async {
                                  {
                                    // Call the AuthService login method with the email and password
                                    User? user = await AuthService().login(
                                      _emailController.text,
                                      _passwordController.text,
                                    );

                                    if (user != null) {
                                      _resetFields();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        'admin-home',
                                        (route) =>
                                            false, // Remove all existing routes
                                      );
                                    } else if (_emailController.text.isEmpty &&
                                        _passwordController.text.isEmpty) {
                                      // Display a red snackbar if the login failed
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              textAlign: TextAlign.center,
                                              'Please enter your email and password'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              textAlign: TextAlign.center,
                                              'Invalid email or password'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(Icons.arrow_forward),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                _resetFields();
                                Navigator.pushNamed(context, 'admin-signup');
                              },
                              child: const Text(
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xff4c505b),
                                  fontSize: 23,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
