// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../provider/sign_up_provider.dart';
import 'signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  int selectedIndex = 1;

  bool isChecked = false;

  bool passwordObscured = true;

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _comfirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  final _nameController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _comfirmpasswordController = TextEditingController();



  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();

    _emailController.dispose();

    _passwordController.dispose();
    _comfirmpasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
  
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Consumer<SignUpProvider>(
        builder: (context, signUp, child) => Form(
          key: _formKey,
          child: signUp.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        child: const CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Please wait',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        Center(
                          child: Container(
                            child: Image.asset('lib/assets/dantown.png'),
                            height: 50,
                            width: 100,
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 20.0, bottom: 10),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.blue),
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.text,
                            controller: _nameController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Name '),
                                    Icon(
                                      Icons.star,
                                      color: Colors.red,
                                      size: 7,
                                    )
                                  ],
                                ),
                                // labelText: 'Phone number',
                                labelStyle: const TextStyle(color: Colors.black),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenSize.width * 0.03),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone Number is required';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.blue),
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.phone,
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Phone number '),
                                    Icon(
                                      Icons.star,
                                      color: Colors.red,
                                      size: 7,
                                    )
                                  ],
                                ),
                                // labelText: 'Phone number',
                                labelStyle: const TextStyle(color: Colors.black),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter your phone number',
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenSize.width * 0.03),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'email is required';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.blue),
                            cursorColor: Colors.blue,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                  left: 15,
                                  top: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                label: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Email '),
                                    Icon(
                                      Icons.star,
                                      color: Colors.red,
                                      size: 7,
                                    )
                                  ],
                                ),
                                // labelText: 'Phone number',
                                labelStyle: const TextStyle(color: Colors.black),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: screenSize.width * 0.03),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5))),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.blue),
                            cursorColor: Colors.blue,
                            controller: _passwordController,
                            obscureText: passwordObscured,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              // labelText: 'Password',
                              label: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Password '),
                                  Icon(
                                    Icons.star,
                                    color: Colors.red,
                                    size: 7,
                                  )
                                ],
                              ),
                              labelStyle: const TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: IconButton(
                                onPressed: (() => setState(() {
                                      passwordObscured = !passwordObscured;
                                    })),
                                icon: Icon(
                                  passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Enter your Password',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(1.0),
                          margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Comfirm Password is required';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.blue),
                            cursorColor: Colors.blue,
                            controller: _comfirmpasswordController,
                            obscureText: passwordObscured,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 15,
                                top: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              // labelText: 'Password',
                              label: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Comfirm Password '),
                                  Icon(
                                    Icons.star,
                                    color: Colors.red,
                                    size: 7,
                                  )
                                ],
                              ),
                              labelStyle: const TextStyle(color: Colors.black),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: IconButton(
                                onPressed: (() => setState(() {
                                      passwordObscured = !passwordObscured;
                                    })),
                                icon: Icon(
                                  passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Comfirm your Password',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            top: 20,
                            bottom: 10,
                          ),
                          child: Consumer<SignUpProvider>(
                            builder: (context, value, child) => GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // _login();
                                  value.isLoading
                                      ? null
                                      : value.simulateSignUp(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim(),
                                          comfirmPassword:
                                              _comfirmpasswordController.text
                                                  .trim(),
                                          name: _nameController.text.trim(),
                                          phoneNumber: _phoneNumberController
                                              .text
                                              .trim(),
                                        );
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 60,
                                width: screenSize.width,
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account? ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageTransition(
                                          child: const SignInScreen(),
                                          type: PageTransitionType.fade,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
