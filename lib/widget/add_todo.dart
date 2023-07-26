import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  const AddToDo({super.key});

  @override
  State<AddToDo> createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Text('Add Todo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Input
                  TextFormField(
                    initialValue: title,
                    decoration: InputDecoration(labelText: 'TITLE'),
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
                  SizedBox(height: 20),

                  // Description Input
                  TextFormField(
                    initialValue: description,
                    decoration: InputDecoration(labelText: 'Description'),
                    textCapitalization: TextCapitalization.sentences,
                    autocorrect: false,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'A Description is needed for your todo';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      description = value!;
                    },
                  ),
                  SizedBox(height: 15),

                  // Save/Cancel Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      minimumSize: Size(double.infinity, 45)
                    ),
                    onPressed: () {}, child: Text('Save', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),))
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}