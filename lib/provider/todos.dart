import 'package:flutter/material.dart';
import '../model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Vorlesung Feldmann anschauen🙃',
      description: '- Aufpassen\n- Mitschriften machen',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Daniel schreiben 😁',
      description: '- Projektarbeitsthema\n- Ideen zur Projektarbeit äußern 💡',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: 'Elektrotechnik lernen 💻',
      description:
          '- Gleichrichter\n- Transistor\n- Diode\n- allg. Grundlagen wiederholen',
    ),
  ];

  // making it public + filtering for only those todo's, that aren't done at the moment
  List<Todo> get todos => _todos.where((todo) => !todo.isDone).toList();
  List<Todo> get todosCompleted => _todos.where((todo) => todo.isDone).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo? todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  bool toggleTodoStatus(Todo? todo) {
    todo?.isDone = !todo.isDone;
    notifyListeners();

    return todo?.isDone ?? false;
  }

  void updateTodo(Todo? todo, String? title, String? description) {
    todo?.title = title;
    todo?.description = description;

    notifyListeners();
  }
}
