import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Daily machen',
      description: 'Ganz viele wichtige Sachen 🧑‍💻',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Daily machen1',
      description: 'Ganz viele wichtige Sachen1 🧑‍💻',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Daily machen2',
      description: 'Ganz viele wichtige Sachen2 🧑‍💻',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Daily machen2',
      description: 'Ganz viele wichtige Sachen2 🧑‍💻',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Daily machen2',
      description: 'Ganz viele wichtige Sachen2 🧑‍💻',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Daily machen2',
      description: 'Ganz viele wichtige Sachen2 🧑‍💻',
    ),
  ];

  // making it public + filtering for only those todo's, that aren't done at the moment
  List<Todo> get todos => _todos.where((todo) => !todo.isDone).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }
}
