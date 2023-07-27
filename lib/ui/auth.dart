import 'package:flutter/material.dart';
import 'package:dantown_test/ui/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebase = FirebaseAuth.instance;
final dataBase = FirebaseFirestore.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final form = GlobalKey<FormState>();

  String firstname = '';
  String lastname = '';
  String email = '';
  dynamic password = '';
  var isLogin = true;
  bool isAuthenticating = false;

  void submit() async {
    final isValid = form.currentState!.validate();

    if (!isValid) {
      return;
    }

    form.currentState!.save();

    try {
      setState(() {
        isAuthenticating = true;
      });
      if (isLogin) {
        // Login an existing user..
        final userCredentials = await firebase.signInWithEmailAndPassword(
            email: email, password: password);

        navigateToNextScreen();
      } else {
        // Create new user..
        final userCredentials = await firebase.createUserWithEmailAndPassword(
            email: email, password: password);

        final userInfo = {
          'Firstname': firstname,
          'Lastname': lastname,
          'Email Address': email,
        };

        dataBase
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set(userInfo);

        navigateToNextScreen();
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')));

      setState(() {
        isAuthenticating = false;
      });
    }
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[250],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(!isLogin ? 'Create Account' : 'Log In',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w700)),
                const SizedBox(height: 5),
                Text(
                  !isLogin
                      ? 'Create an account to keep track of your progress'
                      : 'Login to pen down a task',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 50),

                // Form
                Form(
                  key: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // First Name Input
                      if (!isLogin)
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'First name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (!isLogin) const SizedBox(height: 20),
                      if (!isLogin)
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Firstname',
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please input your first name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            firstname = value!;
                          },
                        ),
                      if (!isLogin) const SizedBox(height: 25),

                      // Last Name Input
                      if (!isLogin)
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Last name',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      if (!isLogin) const SizedBox(height: 20),
                      if (!isLogin)
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Lastname',
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please input your last name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            lastname = value!;
                          },
                        ),
                      if (!isLogin) const SizedBox(height: 25),

                      // Email Input
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email address',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        enableSuggestions: false,
                        validator: (value) {
                          if (value == null ||
                              !value.contains('@') ||
                              value.trim().isEmpty) {
                            return 'Please input a valid email address';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          email = value!;
                        },
                      ),
                      const SizedBox(height: 25),

                      // Password Input
                      const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                        ),
                        obscureText: true,
                        // obscuringCharacter: '*',
                        autocorrect: false,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.length < 6) {
                            return 'Input a valid password not less than 6 characters.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
                      const SizedBox(height: 35),
                      if (isAuthenticating) const CircularProgressIndicator(),

                      // Create Account or Sign Up button
                      if (!isAuthenticating)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            minimumSize: const Size(double.infinity, 55),
                          ),
                          onPressed: submit,
                          child: Text(
                            !isLogin ? 'Create Account' : 'Login',
                            style: const TextStyle(fontSize: 17),
                          ),
                        ),

                      if (!isAuthenticating)
                        // Have an account or Not button
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(!isLogin
                                ? 'Don\'t have an account? create one'
                                : 'Have an account? Log In'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
