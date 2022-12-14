import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common_functions/app_ops.dart';
import 'package:todo_app/models/todos_state.dart';
import 'package:todo_app/pages/todos_list.dart';
import 'package:todo_app/utilities/app_enums.dart';

import '../../persistence/prefs_ops.dart';

class MobileHomeLayout extends StatelessWidget {
  const MobileHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(
              onPressed: () {
                final currentTheme =
                    Provider.of<TodosState>(context, listen: false).appTheme;
                final newTheme = currentTheme == AppThemes.light
                    ? AppThemes.dark
                    : AppThemes.light;
                setAppTheme(newTheme).then((res) {
                  if (res) {
                    Provider.of<TodosState>(context, listen: false)
                        .setAppTheme(newTheme);
                  }
                });
              },
              icon: const Icon(Icons.brightness_2)),
          IconButton(
              onPressed: () =>
                  createEditTodo(context, true, CurrentAction.creating),
              icon: const Icon(
                Icons.edit_note,
                size: 32,
              ))
        ],
      ),
      body: const TodosList(isMobile: true),
    );
  }
}
