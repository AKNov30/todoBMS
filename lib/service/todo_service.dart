import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myproject/constant/db.dart';
import 'package:myproject/models/todo_model.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:myproject/utility/modals.dart';

class ToDoService {
  static Future<List<TodoModel>> getToDoListById(BuildContext context, int userId) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/todo_list/$userId'), headers: apiHeaders);
      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          return [];
        }
        final List<dynamic> jsonList = jsonDecode(response.body);
        final List<TodoModel> toDoList = jsonList.map((data) => TodoModel.fromJson(data as Map<String, dynamic>)).toList();
        return toDoList;
      } else {
        throw Exception('Failed to load to-do list ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
      return [];
    }
  }

  static Future<void> deleteToDoListById(BuildContext context, int todoId) async {
    if (todoId == 0) {
      ModalsHelper.showSnackBar(context, "no have todo Id");
      return;
    }
    try {
      final response = await http.delete(Uri.parse('$apiUrl/delete_todo/$todoId'), headers: apiHeaders);
      if (response.statusCode == 200) {
        ModalsHelper.showSnackBar(context, 'Delete successfully');
      } else {
        throw Exception('Failed to delete to-do list');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }

  static Future<void> createToDo(BuildContext context, TodoModel itemTodo) async {
    try {
      final body = todoModelToJson(itemTodo);
      final response = await http.post(Uri.parse('$apiUrl/create_todo'), headers: apiHeaders, body: body);
      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData == 'OK' || jsonDecode(responseData) is Map<String, dynamic>) {
          ModalsHelper.showSnackBar(context, 'Create Todo Completed');
          Get.offAll(TodoListScreen());
        } else {
          ModalsHelper.showSnackBar(context, 'Unexpected response: $responseData');
        }
      } else {
        ModalsHelper.showSnackBar(context, 'Failed to save');
      }
    } catch (e) {
      print('error: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }

  static Future<void> updateToDo(BuildContext context, TodoModel itemTodo) async {
    inspect(itemTodo);
    try {
      final body = todoModelToJson(itemTodo);
      print("ddd $body");
      final response = await http.post(Uri.parse('$apiUrl/update_todo'), headers: apiHeaders, body: body);
      print(response.body);
      inspect(itemTodo);
      if (response.statusCode == 200 && response.body == "OK") {
        ModalsHelper.showSnackBar(context, 'Update Todo Success');
      } else {
        ModalsHelper.showSnackBar(context, 'Failed to update ToDo');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }
}
