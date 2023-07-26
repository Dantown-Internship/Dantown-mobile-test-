import 'package:dantown_test/model/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoWidget extends StatelessWidget {
  const TodoWidget({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: Key(todo.id ?? ''),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {},
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            )
          ],
        ),
        endActionPane: ActionPane(motion: ScrollMotion(), children: [
          SlidableAction(onPressed: (_) {},
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
                value: todo.isDone,
                onChanged: (_) {},
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  if (todo.description.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        todo.description,
                        maxLines: 3,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    )
                ],
              ))
            ],
          ),
        ));
  }
}
