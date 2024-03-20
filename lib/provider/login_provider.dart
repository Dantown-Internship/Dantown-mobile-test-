// import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../screens/home_screen.dart';

class LoginProvider with ChangeNotifier {
  bool isLoading = false;

  // track the task Process
  bool isTaskComplete = false;

// track the error message, it determines what message to be shown
  String message = '';

  Future simulateSignIn({
    required String email,
    required String password,
    BuildContext? context,
  }) async {
    // show circular progress indicator
    isLoading = true;
    notifyListeners();

    // error widget
    Future showErrorMessage(String message) async {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    }

    // success message
    Future showSuccessMessage(String message) async {
      Get.bottomSheet(
        Container(
          height: 400,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      isLoading = false;
      notifyListeners();
      showSuccessMessage('success');

      return userCredential;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();
      showErrorMessage(e.code);
      notifyListeners();
    }
  }

  //
}
