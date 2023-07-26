import 'package:dantown_test/pages/completed_list_page.dart';
import 'package:dantown_test/pages/todo_list_page.dart';
import 'package:dantown_test/widget/add_todo.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListPage(),
      CompletedListPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('TO DO'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        unselectedItemColor: Colors.grey[300],
        selectedItemColor: Colors.black,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.fact_check_outlined, size: 30),
          label: 'Todos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.done, size: 30),
          label: 'Completed',
          )
        ]),
        body: tabs[selectedIndex],
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.green[400],
          child: Icon(Icons.add, size: 26,),
          onPressed: () => showDialog(context: context, builder: (context) => const AddToDo()),
          ),
    );
  }
}