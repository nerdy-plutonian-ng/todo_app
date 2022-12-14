import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common_functions/app_ops.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/models/todos_state.dart';
import 'package:todo_app/persistence/saver.dart';
import 'package:todo_app/utilities/app_enums.dart';
import 'package:todo_app/widgets/stadium_button.dart';
import 'package:todo_app/widgets/text_stadium_button.dart';
import 'package:uuid/uuid.dart';

class TodoDetail extends StatefulWidget {
  const TodoDetail({
    Key? key,
    required this.isMobile,
  }) : super(key: key);

  final bool isMobile;

  @override
  State<TodoDetail> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  createTodo(TodosState todosState) {
    final newTodo = Todo(
        id: const Uuid().v4(),
        title: todosState.currentTodoObject['title'],
        extra: todosState.currentTodoObject['extra'],
        time: DateTime.now(),
        isCompleted: false);
    final saver = Saver();
    saver.saveTodo(newTodo).then((result) {
      if (result) {
        todosState.addTodo(newTodo);
        todosState.reset();
        if (widget.isMobile) {
          Navigator.pop(context);
        }
      }
    });
  }

  editTodo(TodosState todosState) {
    final todo = Todo(
        id: todosState.currentTodo!.id,
        title: todosState.currentTodoObject['title'],
        extra: todosState.currentTodoObject['extra'],
        time: todosState.currentTodo!.time,
        isCompleted: todosState.currentTodo!.isCompleted);
    final saver = Saver();
    saver.editTodo(todo).then((result) {
      if (result) {
        todosState.editTodo(
            todosState.todos.indexOf(todosState.currentTodo!), todo);
        todosState.reset();
        if (widget.isMobile) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodosState>(builder: (_, todosState, __) {
      return todosState.currentAction == CurrentAction.nothing
          ? SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.folder_copy_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const Text('No todo selected'),
                ],
              ),
            )
          : SizedBox(
              width: widget.isMobile ? double.infinity : 256,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        todosState.currentAction == CurrentAction.creating
                            ? 'New Todo'
                            : 'Edit Todo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StadiumButton(
                              text: 'Save',
                              action: () => todosState.currentAction ==
                                      CurrentAction.creating
                                  ? createTodo(todosState)
                                  : editTodo(todosState)),
                          TextStadiumButton(
                              text: 'Cancel',
                              action: () {
                                todosState.reset();
                                if (widget.isMobile) {
                                  Navigator.pop(context);
                                }
                              }),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                                text: todosState.currentTodo?.title),
                            onChanged: (text) {
                              todosState.currentTodoObject['title'] = text;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Title',
                                isDense: true),
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: TextEditingController(
                                text: todosState.currentTodo?.extra),
                            onChanged: (text) {
                              todosState.currentTodoObject['extra'] = text;
                            },
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Extra text',
                                isDense: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (todosState.currentAction == CurrentAction.editing &&
                      !widget.isMobile)
                    TextButton.icon(
                        onPressed: () {
                          confirmDelete(context, DismissDirection.endToStart)
                              .then((result) {
                            if (result) {
                              deleteTodo(
                                  context,
                                  todosState.currentTodo!,
                                  todosState.todos.indexWhere((element) =>
                                      element.id == todosState.currentTodo!.id),
                                  widget.isMobile);
                            }
                          });
                        },
                        icon: const Icon(Icons.delete_forever),
                        label: const Text('Delete'))
                ],
              ),
            );
    });
  }
}
