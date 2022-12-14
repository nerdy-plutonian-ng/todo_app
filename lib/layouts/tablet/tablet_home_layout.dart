import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/todo_detail.dart';
import 'package:todo_app/pages/todos_list.dart';
import 'package:todo_app/utilities/app_enums.dart';

import '../../common_functions/app_ops.dart';
import '../../models/todos_state.dart';
import '../../persistence/prefs_ops.dart';

class TabletHomeLayout extends StatelessWidget {
  const TabletHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Todo App',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            final currentTheme =
                                Provider.of<TodosState>(context, listen: false)
                                    .appTheme;
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
                          onPressed: () => createEditTodo(
                              context, false, CurrentAction.creating),
                          icon: const Icon(
                            Icons.edit_note,
                            size: 32,
                          )),
                    ],
                  )
                ],
              ),
              const Divider(),
              const Expanded(
                  child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TodosList(isMobile: false),
              )),
            ],
          )),
          const VerticalDivider(),
          const Expanded(
              flex: 2,
              child: TodoDetail(
                isMobile: false,
              )),
        ],
      ),
    ));
  }
}
