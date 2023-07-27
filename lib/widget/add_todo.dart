import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dantown_test/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:dantown_test/provider/todo_provider.dart';

User? user = FirebaseAuth.instance.currentUser;
String currentuserId = user!.uid;

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  // String _userId = currentuserId;

  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    final todo = Todo(
      userId: currentuserId,
      id: DateTime.now().toString(),
      createdTime: DateTime.now(),
      title: title,
      description: description,
    );

    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.addTodo(todo);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              const Text(
                'Add Todo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Input
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'TITLE'),
                      textCapitalization: TextCapitalization.characters,
                      autocorrect: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'A title is needed for your todo';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        title = value!;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Description Input
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: false,
                      onSaved: (value) {
                        description = value!;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Save/Cancel Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            minimumSize: const Size(double.infinity, 45)),
                        onPressed: addTodo,
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
