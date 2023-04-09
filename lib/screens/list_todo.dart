import 'package:flutter/material.dart';

import '../database/hive_functions/db_functions.dart';
import '../database/model/todo_model.dart';

class ListTodo extends StatelessWidget {
  const ListTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
      child: ValueListenableBuilder(
        valueListenable: todo_list_notifier,
        builder: (BuildContext ctx, List<TodoModel> todolist, Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = todolist[index];
              return ListTile(
                title: Text(data.name),
                trailing: IconButton(
                    onPressed: () {
                      delete_todo_from_db(index);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              );
            },
            separatorBuilder: (ctx, index) {
              return Divider(
                thickness: 2,
                color: Colors.black,
              );
            },
            itemCount: todolist.length,
          );
        },
      ),
    );
  }
}
