import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dantown_test/model/todo.dart';

class FirebaseApi {

  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());
    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos(String userId) => FirebaseFirestore.instance
      .collection('todo')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((querySnapshot) => querySnapshot.docs
          .map<Todo>((doc) => Todo.fromJson(doc.data()))
          .toList());

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteToDo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}
