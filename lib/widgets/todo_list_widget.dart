import 'package:flutter/material.dart';
import 'package:todo_application/provider/todos.dart';
import 'package:provider/provider.dart';
import './todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos; // executes getter

    return todos.isEmpty
        ? const Center(
            child: Text(
              'No Todos!',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: todos.length,
            separatorBuilder: (context, index) => Container(height: 10),
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
          );
  }
}
