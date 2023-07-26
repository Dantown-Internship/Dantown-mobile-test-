import 'package:dantown_test/model/todo.dart';
import 'package:flutter/material.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Walk the Dog',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Code in the evening',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Buy Food',
      description: '''- Eggs - Milk - Bread -Water'''
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Plan Family trip tto Norway',
      description: '''- Rent some hotels - Rent a car - Pack suitcase'''
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();
}
