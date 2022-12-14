import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/todos_state.dart';
import 'package:todo_app/utilities/app_enums.dart';

import '../common_functions/app_ops.dart';
import '../persistence/saver.dart';

class ListItem extends StatelessWidget {
  const ListItem(
      {Key? key,
      required this.todo,
      required this.isMobile,
      required this.index})
      : super(key: key);

  final Todo todo;
  final bool isMobile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(todo.id),
      title: Text(todo.title),
      subtitle: Text(
          '${DateFormat.yMMMd().format(todo.time)}  ${TimeOfDay.fromDateTime(todo.time).format(context)}'),
      trailing: IconButton(
        onPressed: () {
          final newTodo = Todo(
              id: todo.id,
              title: todo.title,
              extra: todo.extra,
              time: todo.time,
              isCompleted: !todo.isCompleted);
          Saver().editTodo(newTodo).then((result) {
            if (result) {
              Provider.of<TodosState>(context, listen: false)
                  .editTodo(index, newTodo);
            }
          });
        },
        icon: Icon(
          todo.isCompleted ? Icons.check : Icons.check_box_outline_blank,
          color: todo.isCompleted
              ? Colors.green
              : Theme.of(context).colorScheme.primary,
        ),
      ),
      onTap: () {
        Provider.of<TodosState>(context, listen: false).setCurrentTodo(todo);
        Provider.of<TodosState>(context, listen: false)
            .setCurrentTodoObjectPartial('title', todo.title);
        Provider.of<TodosState>(context, listen: false)
            .setCurrentTodoObjectPartial('extra', todo.extra);
        Provider.of<TodosState>(context, listen: false)
            .setCurrentAppAction(CurrentAction.editing);
        if (isMobile) {
          createEditTodo(
            context,
            true,
            CurrentAction.editing,
          );
        }
      },
      tileColor: todo.id ==
                  Provider.of<TodosState>(context, listen: false)
                      .currentTodo
                      ?.id &&
              !isMobile
          ? Colors.deepPurple[100]
          : null,
    );
  }
}
