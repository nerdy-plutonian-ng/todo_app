// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.extra,
    required this.time,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String extra;
  final DateTime time;
  final bool isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["_id"],
        title: json["title"],
        extra: json["extra"],
        time: DateTime.parse(json["time"]),
        isCompleted: json["isCompleted"] == 1,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "extra": extra,
        "time": time.toIso8601String(),
        "isCompleted": isCompleted ? 1 : 0,
      };

  static Todo todoFromJson(String str) => Todo.fromJson(json.decode(str));

  static String todoToJson(Todo data) => json.encode(data.toJson());

  static List<Todo> getTodosFromMaps(List<Map<String,dynamic>> maps) => List<Todo>.generate(maps.length, (index) => Todo.fromJson(maps[index]));
}
