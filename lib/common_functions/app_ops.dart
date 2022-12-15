import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todos_state.dart';
import 'package:todo_app/pages/todo_detail.dart';
import 'package:todo_app/persistence/saver.dart';
import 'package:todo_app/utilities/app_enums.dart';

import '../models/todo.dart';

createEditTodo(
    BuildContext context, bool isMobile, CurrentAction currentAction) {
  Provider.of<TodosState>(context, listen: false)
      .setCurrentAppAction(currentAction);
  if (currentAction == CurrentAction.creating) {
    Provider.of<TodosState>(context, listen: false).setCurrentTodo(null);
  }
  if (isMobile) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return const FractionallySizedBox(
            heightFactor: 0.95,
            child: TodoDetail(
              isMobile: true,
            ),
          );
        });
  } else {
    Provider.of<TodosState>(context, listen: false)
        .setCurrentAppAction(CurrentAction.creating);
  }
}

deleteTodo(BuildContext context, Todo todo, int index, bool isMobile) {
  final saver = Saver();
  saver.deleteTodo(todo.id).then((result) {
    if (result) {
      Provider.of<TodosState>(context, listen: false).removeTodo(index);
      Provider.of<TodosState>(context, listen: false).reset();
    }
  });
}

Future<bool> confirmDelete(
    BuildContext context, DismissDirection dismissDirection) async {
  if (Platform.isAndroid || Platform.isWindows) {
    return await showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteConfirmation),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                  )),
            ],
          );
        });
  } else {
    return await showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text(AppLocalizations.of(context)!.deleteConfirmation),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel)),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                  )),
            ],
          );
        });
  }
}
