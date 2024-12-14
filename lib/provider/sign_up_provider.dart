// ignore_for_file: no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/home_screen.dart';

class SignUpProvider with ChangeNotifier {
  bool isLoading = false;

  // track the task Process
  bool isTaskComplete = false;

// track the error message, it determines what message to be shown
  String message = '';

  Future simulateSignUp({
    required String email,
    required String password,
    required String comfirmPassword,
    required String name,
    required String phoneNumber,
    BuildContext? context,
  }) async {
    // show circular progress indicator
    isLoading = true;
    notifyListeners();

    //
    void showErrorMessage(String message) {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'lib/assets/warning.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    }

    Future showSuccessMessage(String message) async {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // SizedBox(
            //   height: 20,
            // ),
            Container(
              height: 200,
              width: double.maxFinite,
              child: Image.asset(
                'lib/assets/success.png',
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              message,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ]),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();

        Get.off(() => const HomeScreen());
      });
    }

    final FirebaseAuth _auth = FirebaseAuth.instance;

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      if (password == comfirmPassword) {
        // create user
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        _firestore.collection('Users').doc(userCredential.user!.uid).set(
          {
            'Name': name,
            'Email': email,
            'Phone Number': phoneNumber,
            'Uid': userCredential.user!.uid,
          },
          // SetOptions(merge: true),
        );

        User? user = FirebaseAuth.instance.currentUser;

        FirebaseFirestore.instance.collection('task').doc(user!.email).set(
          {
            'tasks': [],
          },
          SetOptions(merge: true),
        );

        isLoading = false;
        notifyListeners();
        showSuccessMessage('success');
      } else {
        isLoading = false;
        notifyListeners();
        showErrorMessage("Password don't match");
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      showErrorMessage(e.code);
      notifyListeners();
    }
  }
}
