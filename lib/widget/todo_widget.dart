import 'package:dantown_test/model/todo.dart';
import 'package:dantown_test/provider/todo_provider.dart';
// import 'package:dantown_test/widget/add_todo.dart';
import 'package:dantown_test/widget/edit_todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    void deleteToDo() {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.removeTodo(widget.todo);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted the task')));
    }

    void editToDo() {
      // final provider = Provider.of<TodosProvider>(context);
      // provider.editTodo(widget.todo);

      Navigator.push(context, MaterialPageRoute(builder: (context) => EditToDo(todo: widget.todo)));
    }


    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Slidable(
          key: Key(widget.todo.id ?? ''),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  editToDo();
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Edit',
              )
            ],
          ),
          endActionPane: ActionPane(motion: ScrollMotion(), children: [
            SlidableAction(
              onPressed: (_) {
                deleteToDo();
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            )
          ]),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                  value: widget.todo.isDone,
                  onChanged: (_) {
                    final provider = Provider.of<TodosProvider>(context, listen: false);
                  final isDone = provider.toggleTodoStatus(widget.todo);

                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isDone ? 'Task completed' : 'Task marked incomplete',)));
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todo.title,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    if (widget.todo.description.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: Text(
                          widget.todo.description,
                          maxLines: 3,
                          style: TextStyle(fontSize: 16, height: 1.5),
                        ),
                      )
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
