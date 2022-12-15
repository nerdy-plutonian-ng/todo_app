import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todos_state.dart';
import 'package:todo_app/persistence/prefs_ops.dart';
import 'package:todo_app/persistence/saver.dart';
import 'package:todo_app/utilities/app_enums.dart';
import 'package:todo_app/utilities/route_generator.dart';

import 'models/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final todos = await Saver().getTodos();
  final theme = await getAppTheme();
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodosState(),
      child: TodoApp(
        todos: todos,
        theme: theme,
      ),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key, required this.todos, required this.theme})
      : super(key: key);

  final List<Todo> todos;
  final AppThemes theme;

  @override
  Widget build(BuildContext context) {
    Provider.of<TodosState>(context, listen: false).setTodosSilent(todos);
    Provider.of<TodosState>(context, listen: false).setAppThemeSilent(theme);
    return Consumer<TodosState>(builder: (_, todoState, __) {
      return MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: todoState.appTheme == AppThemes.light
                  ? Brightness.light
                  : Brightness.dark),
        ),
        onGenerateRoute: (routeSettings) => generateRoute(routeSettings),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('es'),
        ],
      );
    });
  }
}
