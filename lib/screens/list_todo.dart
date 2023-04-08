import 'package:flutter/material.dart';

import '../database/model/todo.dart';
import '../functions/functions.dart';

class ListTodo extends StatelessWidget {
  const ListTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: ValueListenableBuilder(
        valueListenable: todo_list_notifier,
        builder: (BuildContext ctx, List<TodoModel> todolist, Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = todolist[index];
              return ListTile(
                title: Text(data.name),
              );
            },
            separatorBuilder: (ctx, index) {
              return Divider(
                thickness: 2,
                color: Colors.red[400],
              );
            },
            itemCount: todolist.length,
          );
        },
      ),
    );
  }
}
