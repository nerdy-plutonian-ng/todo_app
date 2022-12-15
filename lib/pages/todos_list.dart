import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common_functions/app_ops.dart';
import 'package:todo_app/models/todos_state.dart';
import 'package:todo_app/widgets/list_item.dart';
import 'package:todo_app/widgets/no_todos.dart';

class TodosList extends StatelessWidget {
  const TodosList({Key? key, required this.isMobile}) : super(key: key);

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosState>(
      builder: (_, todosState, __) {
        return todosState.todos.isEmpty
            ? NoTodos(isMobile: isMobile)
            : ListView.separated(
                itemBuilder: (_, index) {
                  return isMobile
                      ? Dismissible(
                          confirmDismiss: (dismissDirection) =>
                              confirmDelete(context, dismissDirection),
                          onDismissed: (dismissedDirection) => deleteTodo(
                              context,
                              todosState.todos[index],
                              index,
                              isMobile),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.delete,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                          key: Key(todosState.todos[index].id),
                          child: ListItem(
                            todo: todosState.todos[index],
                            isMobile: isMobile,
                            index: index,
                          ),
                        )
                      : ListItem(
                          key: Key(todosState.todos[index].id),
                          todo: todosState.todos[index],
                          isMobile: isMobile,
                          index: index,
                        );
                },
                separatorBuilder: (_, index) {
                  return const Divider();
                },
                itemCount: todosState.todos.length);
      },
    );
  }
}
