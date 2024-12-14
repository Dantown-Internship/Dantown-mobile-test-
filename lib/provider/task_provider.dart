import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class TaskProvider extends ChangeNotifier {
  bool isLoading = false;

  // track the task Process
  bool isTaskComplete = false;

// track the error message, it determines what message to be shown
  String message = '';

  // success message
  Future showSuccessMessage(String message) async {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.green,
    ).close();
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.green,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }

  // error message
  Future showErrorMessage(String message) async {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.red,
    ).close();
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.red,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.back();
    });
  }

  // create post

  addTask(title, description) {
    isLoading = true;
    notifyListeners();

    String taskId = const Uuid().v4();
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('task').doc(user!.email);

    // retrieve current list

    documentRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        List<dynamic> currentlist = documentSnapshot['tasks'];

        // add new data to the list
        currentlist.add({
          'id': taskId,
          'title': title,
          'description': description,
        });
        // update list to current list
        documentRef.update({'tasks': currentlist});
        isLoading = false;
        showSuccessMessage('Task Added');
        notifyListeners();
      } else {
        print('document does not exist');
      }
    }).catchError((error) {
      print('error retriving document: $error');
      isLoading = false;
      notifyListeners();
      showErrorMessage('${error}');
      notifyListeners();
    });
  }

// upadte post
  updateTask(taskDetailsIndexId, title, description) {
    isLoading = true;
    notifyListeners();
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('task').doc(user!.email);

    // retrieve current list

    documentRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        List<dynamic> currentlist = documentSnapshot['tasks'];

        // iterate through list

        for (int index = 0; index < currentlist.length; index++) {
          if (currentlist[index]['id'] == taskDetailsIndexId) {
            currentlist[index] = {
              'title': title,
              'description': description,
            };

            break;
          }
        }
        documentRef.update({'tasks': currentlist});
        isLoading = false;
        notifyListeners();
        showSuccessMessage('Task Updated');
      } else {
        print('document does not exist');
        isLoading = false;
        notifyListeners();
      }
    }).catchError((error) {
      print('error retriving document: $error');
      isLoading = false;
      notifyListeners();
      showErrorMessage('${error}');
    });
  }

// upadte post
  updateTitleTask(taskDetailsIndexId, title) {
    isLoading = true;
    notifyListeners();
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('task').doc(user!.email);

    // retrieve current list

    documentRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        List<dynamic> currentlist = documentSnapshot['tasks'];

        // iterate through list

        for (int index = 0; index < currentlist.length; index++) {
          if (currentlist[index]['id'] == taskDetailsIndexId) {
            currentlist[index]['title'] = title;

            // currentlist[index] = {'title': title};

            break;
          }
        }
        documentRef.update({'tasks': currentlist});
        isLoading = false;
        notifyListeners();
        showSuccessMessage('Task Updated');
      } else {
        print('document does not exist');
        isLoading = false;
        notifyListeners();
      }
    }).catchError((error) {
      print('error retriving document: $error');
      isLoading = false;
      notifyListeners();
      showErrorMessage('${error}');
    });
  }

// upadte post
  updateDescriptionTask(taskDetailsIndexId, description) {
    isLoading = true;
    notifyListeners();
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('task').doc(user!.email);

    // retrieve current list

    documentRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        List<dynamic> currentlist = documentSnapshot['tasks'];

        // iterate through list

        for (int index = 0; index < currentlist.length; index++) {
          if (currentlist[index]['id'] == taskDetailsIndexId) {
            currentlist[index]['description'] = description;

            // currentlist[index] = {
            //   'description': description,
            // };

            break;
          }
        }
        documentRef.update({'tasks': currentlist});
        isLoading = false;
        notifyListeners();
        showSuccessMessage('Task Updated');
      } else {
        print('document does not exist');
        isLoading = false;
        notifyListeners();
      }
    }).catchError((error) {
      print('error retriving document: $error');
      isLoading = false;
      notifyListeners();
      showErrorMessage('${error}');
    });
  }

  // delete post

  deleteTask(taskDetailsIndexId) {
    isLoading = true;
    notifyListeners();
    User? user = FirebaseAuth.instance.currentUser;
    DocumentReference documentRef =
        FirebaseFirestore.instance.collection('task').doc(user!.email);

    documentRef.get().then(
      (documentSnapshot) {
        if (documentSnapshot.exists) {
          List<dynamic> currentlist = documentSnapshot['tasks'];

          // iterate through list

          for (int index = 0; index < currentlist.length; index++) {
            if (currentlist[index]['id'] == taskDetailsIndexId) {
              currentlist.removeAt(index);
              break;
            }
          }
          documentRef.update({'tasks': currentlist});
          isLoading = false;
          notifyListeners();
          showSuccessMessage('Task Deleted');
        } else {
          print('document does not exist');
          isLoading = false;
          notifyListeners();
        }
      },
    ).catchError(
      (error) {
        print('error retriving document: $error');
        isLoading = false;
        notifyListeners();
        showErrorMessage('${error}');
      },
    );
  }
}
