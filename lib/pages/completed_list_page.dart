import 'package:flutter/material.dart';
import 'package:dantown_test/provider/todo_provider.dart';
import 'package:dantown_test/widget/todo_widget.dart';
import 'package:provider/provider.dart';

class CompletedListPage extends StatelessWidget {
  const CompletedListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context, listen: true);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Center(child: Text('No completed todo...', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),))
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: todos.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todos[index];

              return TodoWidget(todo: todo);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 3.0,
                color: Colors.black,
              );
            },
          );
  }
}