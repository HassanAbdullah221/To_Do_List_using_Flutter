import 'package:flutter/material.dart';
import 'package:to_do_list/to_do.dart';

import 'colors.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;
  const ToDoItem({
    super.key,
    required this.todo,
    this.onToDoChange,
    this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Blue,
        ),
        title: Text(
          todo.todotext!,
          style: TextStyle(
            fontSize: 16,
            color: Black,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
            onPressed: () {
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
