import 'package:flutter/foundation.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utilities/app_enums.dart';

class TodosState extends ChangeNotifier {
  bool isMobile = true;

  Todo? currentTodo;

  CurrentAction currentAction = CurrentAction.nothing;

  List<Todo> _todos = [];

  List<Todo> get todos {
    return _todos;
  }

  Map<String, dynamic> currentTodoObject = {
    'title': '',
    'extra': '',
  };

  AppThemes? appTheme;

  setCurrentTodoObjectPartial(String key, Object? value) {
    currentTodoObject[key] = value;
    notifyListeners();
  }

  setCurrentTodoObject(Map<String, dynamic> currentTodoObject) {
    this.currentTodoObject = currentTodoObject;
    notifyListeners();
  }

  reset() {
    currentTodoObject = {
      'title': '',
      'extra': '',
    };
    currentAction = CurrentAction.nothing;
    currentTodo = null;
    notifyListeners();
  }

  setTodosSilent(List<Todo> todos) {
    _todos = todos;
  }

  setTodos(List<Todo> todos) {
    _todos = todos;
    notifyListeners();
  }

  addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  removeTodo(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  clearTodos() {
    _todos.clear();
    notifyListeners();
  }

  editTodo(int index, Todo todo) {
    _todos[index] = todo;
    notifyListeners();
  }

  setCurrentAppAction(CurrentAction currentAction) {
    this.currentAction = currentAction;
    notifyListeners();
  }

  setIsMobileFirstTime(bool isMobile) {
    this.isMobile = isMobile;
  }

  setIsMobile(bool isMobile) {
    this.isMobile = isMobile;
    notifyListeners();
  }

  setCurrentTodo(Todo? currentTodo) {
    this.currentTodo = currentTodo;
    notifyListeners();
  }

  setAppTheme(AppThemes appTheme) {
    this.appTheme = appTheme;
    notifyListeners();
  }

  setAppThemeSilent(AppThemes appTheme) {
    this.appTheme = appTheme;
  }
}
