import '../models/todo.dart';
import 'save_on_device.dart';

class Saver {
  final saver = TodoSaverDevice();

  Future<bool> saveTodo(Todo todo) async {
    return await saver.saveTodo(todo);
  }

  Future<bool> editTodo(Todo todo) async {
    return await saver.editTodo(todo);
  }

  Future<bool> deleteTodo(String id) async {
    return await saver.deleteTodo(id);
  }

  Future<List<Todo>> getTodos() async {
    return await saver.getTodos();
  }
}
