import 'package:cloud_firestore/cloud_firestore.dart';

class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  DateTime createdTime;
  String title;
  String? id;
  String description;
  bool isDone;
  String? userId;

  Todo({
    required this.createdTime,
    required this.title,
    this.description = '',
    this.id,
    this.isDone = false,
    this.userId,
  });

  Map<String, dynamic> toJson() => {
        'createdTime': createdTime,
        'title': title,
        'description': description,
        'id': id,
        'isDone': isDone,
        'userId': userId,
  };

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      createdTime: (json['createdTime'] as Timestamp).toDate(),
      title: json['title'],
      description: json['description'],
      id: json['id'],
      isDone: json['isDone'],
      userId: json['userId']
    );
  }
}
