import 'package:flutter/material.dart';
import 'package:todo_application/utils.dart';
import '../model/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../provider/todos.dart';

class TodoWidget extends StatelessWidget {
  final Todo? todo;

  const TodoWidget({@required this.todo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          key: Key(todo?.id ?? '1'),
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                backgroundColor: Colors.green,
                label: 'Edit',
                icon: Icons.edit,
                onPressed: (context) {},
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                backgroundColor: Colors.red,
                label: 'Delete',
                icon: Icons.delete,
                onPressed: (context) => deleteTodo(context, todo),
              ),
            ],
          ),
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: todo?.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(todo);

                Utils.showSnackBar(
                  context,
                  isDone ? 'Todo completed' : 'Todo marked as incomplete',
                );
              },
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo?.title ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                  if (todo?.description.isNotEmpty ?? false)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(
                        todo?.description ?? "",
                        style: const TextStyle(
                          fontSize: 20,
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );

  void deleteTodo(BuildContext context, Todo? todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'The Todo was deleted');
  }
}
