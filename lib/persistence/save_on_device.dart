import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/todo.dart';
import 'todo_saver.dart';

const String tableTodo = 'todos';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnExtra = 'extra';
const String columnTime = 'time';
const String columnIsCompleted = 'isCompleted';

const createTodosTable = '''
create table $tableTodo ( 
  $columnId text primary key, 
  $columnTitle text not null,
  $columnExtra text not null,
  $columnTime text not null,
  $columnIsCompleted integer
  )
''';

class TodoSaverDevice implements TodoSaver {
  late Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todos.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(createTodosTable);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {});
  }

  @override
  Future<List<Todo>> getTodos() async {
    await open();
    final res = await db.query(
      tableTodo,
    );
    await close();
    return Todo.getTodosFromMaps(res);
  }

  @override
  Future<bool> saveTodo(Todo todo) async {
    await open();
    final id = await db.insert(tableTodo, todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
    await close();
    return id > 0;
  }

  @override
  Future<bool> editTodo(Todo todo) async {
    await open();
    final res = await db.update(tableTodo, todo.toJson(),
        where: '$columnId = ?', whereArgs: [todo.id]);
    await close();
    return res > 0;
  }

  @override
  Future<bool> deleteTodo(String id) async {
    await open();
    final res =
        await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
    await close();
    return res > 0;
  }

  Future close() async => db.close();
}
