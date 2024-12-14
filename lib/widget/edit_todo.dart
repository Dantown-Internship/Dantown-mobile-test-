import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dantown_test/provider/todo_provider.dart';
import 'package:dantown_test/model/todo.dart';

class EditToDo extends StatefulWidget {
  const EditToDo({super.key, required this.todo});
  final Todo todo;

  @override
  State<EditToDo> createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    title = widget.todo.title;
    description = widget.todo.description;
  }

  String title = '';
  String description = '';

  void _save() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      _formKey.currentState!.save();
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              final provider =
                  Provider.of<TodosProvider>(context, listen: false);
              provider.removeTodo(widget.todo);

              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Edit Title Input Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'TITLE'),
                initialValue: title,
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
              const SizedBox(height: 15),

              // Edit Description Input Field
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                initialValue: description,
                textCapitalization: TextCapitalization.sentences,
                onSaved: (value) {
                  description = value!;
                },
              ),
              SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    minimumSize: const Size(double.infinity, 45)),
                onPressed: _save,
                child: const Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
