import '../models/todo.dart';

abstract class TodoSaver {
  Future<bool> saveTodo(Todo todo);

  Future<List<Todo>> getTodos();

  Future<bool> editTodo(Todo todo);

  Future<bool> deleteTodo(String id);
}
