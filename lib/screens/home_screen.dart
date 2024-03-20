// ignore_for_file: unnecessary_string_interpolations, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../provider/task_provider.dart';
import '../widgets/popup_menu_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Future addTasks() async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.blue,
                title: const Text(
                  'Edit Task',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                content: SizedBox(
                  height: 150,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                          controller: _titleController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: 'Enter Title',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description is required';
                            }
                            return null;
                          },
                          controller: _descriptionController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              hintText: 'Enter Description',
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        TaskProvider().addTask('${_titleController.text}',
                            '${_descriptionController.text}');
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          addTasks();
        },
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Tasks'),
        centerTitle: true,
        elevation: 0,
        actions: const [
          PopUpMenuButtonWidget(),
        ],
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('task')
            .doc(user!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            List taskDetails = userData['tasks'];

            return ListView.builder(
                itemCount: taskDetails.length,
                itemBuilder: (context, index) {
                  TaskProvider _taskProvider = TaskProvider();

                  var taskDetailsIndexId = taskDetails[index]['id'];

                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                        left: 20,
                        right: 20,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    'Title',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Text(
                                    '${taskDetailsIndexId}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              editfield() async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    title: const Text(
                                                      'Edit Task',
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    content: SizedBox(
                                                      height: 150,
                                                      child: Column(
                                                        children: [
                                                          TextField(
                                                            controller:
                                                                _titleController,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                            decoration: const InputDecoration(
                                                                hintText:
                                                                    'Enter Title',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                          ),
                                                          TextField(
                                                            controller:
                                                                _descriptionController,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                            decoration: const InputDecoration(
                                                                hintText:
                                                                    'Enter Description',
                                                                hintStyle: TextStyle(
                                                                    color: Colors
                                                                        .white)),
                                                            onChanged: (value) {
                                                              // newValue = value;
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            if (_titleController
                                                                    .text
                                                                    .isNotEmpty &&
                                                                _descriptionController
                                                                    .text
                                                                    .isEmpty) {
                                                              _taskProvider.updateTitleTask(
                                                                  taskDetailsIndexId,
                                                                  _titleController
                                                                      .text);
                                                              // update title
                                                            } else if (_titleController
                                                                    .text
                                                                    .isEmpty &&
                                                                _descriptionController
                                                                    .text
                                                                    .isNotEmpty) {
                                                              _taskProvider.updateDescriptionTask(
                                                                  taskDetailsIndexId,
                                                                  _descriptionController
                                                                      .text);
                                                              // update description
                                                            } else if (_titleController
                                                                    .text
                                                                    .isNotEmpty &&
                                                                _descriptionController
                                                                    .text
                                                                    .isNotEmpty) {
                                                              // update title and description
                                                              _taskProvider.updateTask(
                                                                  taskDetailsIndexId,
                                                                  _titleController
                                                                      .text,
                                                                  _descriptionController
                                                                      .text);
                                                            }

                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            'Update',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                );
                                              }

                                              editfield();
                                            },
                                            child:
                                                const Icon(Icons.edit_document),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              deleteTask() async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    backgroundColor:
                                                        Colors.blue,
                                                    title: const Text(
                                                      'Delete Task',
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: const Text(
                                                            'No',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            _taskProvider
                                                                .deleteTask(
                                                                    taskDetailsIndexId);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            'Yes',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                );
                                              }

                                              deleteTask();
                                            },
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              // height: 40,
                              // width: screenSize.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${taskDetails[index]['title']}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // height: 100,
                              width: screenSize.width,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${taskDetails[index]['description']}',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text('data'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
