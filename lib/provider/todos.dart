import 'package:flutter/material.dart';
import 'package:todo_application/api/firebase_api.dart';
import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];

  // making it public + filtering for only those todo's, that aren't done at the moment
  List<Todo> get todos => _todos.where((todo) => !todo.isDone).toList();
  List<Todo> get todosCompleted => _todos.where((todo) => todo.isDone).toList();

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo? todo) => FirebaseApi.deleteTodo(todo!);

  bool toggleTodoStatus(Todo? todo) {
    todo?.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo!);

    return todo.isDone;
  }

  void updateTodo(Todo? todo, String? title, String? description) {
    todo?.title = title;
    todo?.description = description;

    FirebaseApi.updateTodo(todo!);
  }
}
