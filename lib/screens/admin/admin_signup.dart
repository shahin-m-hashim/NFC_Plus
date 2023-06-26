import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../authentication/services/auth_services.dart';
import '../../authentication/services/validation.dart';

class AdminSignUp extends StatefulWidget {
  const AdminSignUp({Key? key}) : super(key: key);

  @override
  _AdminSignUpState createState() => _AdminSignUpState();
}

class _AdminSignUpState extends State<AdminSignUp> {
  // Text editing controllers for the fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Whether to show the password or not
  bool _obscureText = true;

  // Whether the fields are in error
  bool _nameError = false;
  bool _phoneError = false;
  bool _emailError = false;
  bool _passwordError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _resetFields() {
    FocusScope.of(context).unfocus();
    _emailError = false;
    _passwordError = false;
    _phoneError = false;
    _nameError = false;
    setState(() {
      _nameController.clear();
      _phoneController.clear();
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
            image: AssetImage('assets/images/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 170),
                          child: const Text(
                            'Create\nAccount',
                            style: TextStyle(color: Colors.white, fontSize: 37),
                          ),
                        ),
                        const SizedBox(height: 95),
                        TextField(
                          controller: _nameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            errorText: _nameError
                                ? Validator.validateName(_nameController.text)
                                : null,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Name",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _nameError =
                                  Validator.validateName(value) != null;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            errorText: _phoneError
                                ? Validator.validatePhone(_phoneController.text)
                                : null,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Phone",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _phoneError =
                                  Validator.validatePhone(value) != null;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorText: _emailError
                                ? Validator.validateEmail(_emailController.text)
                                : null,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _emailError =
                                  Validator.validateEmail(value) != null;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          style: const TextStyle(color: Colors.white),
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white),
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
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () async {
                                  final name = _nameController.text;
                                  final email = _emailController.text;
                                  final phone = _phoneController.text;
                                  final password = _passwordController.text;

                                  try {
                                    final AuthService _authService =
                                        AuthService();
                                    final user = await _authService
                                        .signUpWithEmailAndPassword(
                                      email: email,
                                      password: password,
                                      name: name,
                                      phoneNumber: phone,
                                    );
                                    if (user != null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 5),
                                          backgroundColor: Colors.green,
                                          content: Text(
                                              textAlign: TextAlign.center,
                                              'Account Created Successfully'),
                                        ),
                                      );
                                      _resetFields();
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    print(e);
                                    if (e is FirebaseAuthException &&
                                        e.code == 'email-already-in-use') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          content: Text(
                                              textAlign: TextAlign.center,
                                              'The Entered Email already exists'),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          duration: Duration(seconds: 3),
                                          content: Text(
                                              textAlign: TextAlign.center,
                                              'Error creating account. Please try again later.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.arrow_forward,
                                ),
                              ),
                            )
                          ],
                        ),
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
