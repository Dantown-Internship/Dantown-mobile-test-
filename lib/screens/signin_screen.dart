// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

import '../provider/login_provider.dart';

import 'sign_up_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool passwordObscured = true;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(
        builder: (context, loginP, child) => Form(
          key: _formKey,
          child: loginP.isLoading
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
                          padding: EdgeInsets.only(left: 20.0, bottom: 10),
                          child: Text(
                            'Login',
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
                                return 'Email is required';
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
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: screenSize.width * 0.03),
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
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
                                borderSide:
                                    const BorderSide(color: Colors.black),
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
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, top: 5, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Consumer<LoginProvider>(
                          builder: (context, si, child) => GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                si.isLoading
                                    ? null
                                    : si.simulateSignIn(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20,
                                top: 20,
                                bottom: 10,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: 60,
                                width: screenSize.width,
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
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
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      "Don't have an account? ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageTransition(
                                          child: const SignUpScreen(),
                                          type: PageTransitionType.fade,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Sign Up",
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
