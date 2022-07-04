import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/add_todo_dialog_widget.dart';
import '../widgets/todo_list_widget.dart';
import '../widgets/completed_list_widget.dart';

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
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Current Todos',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.done, size: 28),
            label: 'Completed Todos',
          ),
        ],
      ),
      body: tabs[selectedIndex],
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
