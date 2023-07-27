import 'package:dantown_test/api/firebase_api.dart';
import 'package:dantown_test/model/todo.dart';
import 'package:dantown_test/pages/completed_list_page.dart';
import 'package:dantown_test/pages/todo_list_page.dart';
import 'package:dantown_test/provider/todo_provider.dart';
import 'package:dantown_test/widget/add_todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    final tabs = [
      const TodoListPage(),
      const CompletedListPage(),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('TO DO'),
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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined, size: 30),
              label: 'Todos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 30),
              label: 'Completed',
            )
          ]),
      body: StreamBuilder<List<Todo>>(
        stream: FirebaseApi.readTodos(userId),
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final todos = snapshot.data;
            final provider = Provider.of<TodosProvider>(context);

            provider.setTodos(todos!);

            return tabs[selectedIndex];
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.green[400],
        child: const Icon(
          Icons.add,
          size: 26,
        ),
        onPressed: () =>
            showDialog(context: context, builder: (context) => const AddToDo()),
      ),
    );
  }
}
