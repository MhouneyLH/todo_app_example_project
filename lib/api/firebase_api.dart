import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo.dart';
import '../utils.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    // 1 new doc -> 1 new todo
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }
}
