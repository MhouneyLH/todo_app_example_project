import 'package:flutter/material.dart';
import 'package:todo_application/api/firebase_api.dart';
import 'package:todo_application/model/todo.dart';
import 'package:todo_application/provider/todos.dart';
import '../main.dart';
import '../widgets/add_todo_dialog_widget.dart';
import '../widgets/todo_list_widget.dart';
import '../widgets/completed_list_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const TodoListWidget(),
      const CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Current Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed Todos',
          ),
        ],
      ),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint('DAS HIER IST DER FEHLER: ' + snapshot.error.toString());
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final todos = snapshot.data!;
            // hier keine data (keine snap-elemente) -> könnte an Returnwert von Stream-Funktion liegen
            // -> mal überprüfen, s. https://stackoverflow.com/questions/66951442/streambuilder-snapshot-has-no-data-flutter
            String t = todos.elementAt(todos.length - 1).title ?? 'hier';
            debugPrint('HIIIIIIIIIIIIIIIIIIER: ' + t);
            final provider = Provider.of<TodosProvider>(context);

            provider.setTodos(todos);
            return tabs[selectedIndex];
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => const AddToDoDialogWidget(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
