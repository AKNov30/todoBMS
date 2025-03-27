import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  int? userTodoListId;
  String? userTodoListTitle;
  String? userTodoListDesc;
  String? userTodoListCompleted;
  DateTime? userTodoListLastUpdate;
  int? userId;

  TodoModel({
    this.userTodoListId,
    this.userTodoListTitle,
    this.userTodoListDesc,
    this.userTodoListCompleted,
    this.userTodoListLastUpdate,
    this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    userTodoListId: json["user_todo_list_id"],
    userTodoListTitle: json["user_todo_list_title"],
    userTodoListDesc: json["user_todo_list_desc"],
    userTodoListCompleted: json["user_todo_list_completed"],
    userTodoListLastUpdate: DateTime.parse(json["user_todo_list_last_update"]),
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_todo_list_id": userTodoListId,
    "user_todo_list_title": userTodoListTitle,
    "user_todo_list_desc": userTodoListDesc,
    "user_todo_list_completed": userTodoListCompleted,
    "user_todo_list_last_update": userTodoListLastUpdate?.toIso8601String(),
    "user_id": userId,
    "user_todo_type_id": 1,
  };
}
