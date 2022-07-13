import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    // 1 new doc -> 1 new todo
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .orderBy(TodoField.createdTime, descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Todo.fromJson(doc.data())).toList());
}
