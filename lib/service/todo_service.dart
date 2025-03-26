import 'dart:convert';
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

  static Future<void> deleteToDoListById(BuildContext context, String todoListId) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/delete_todo/$todoListId'), headers: apiHeaders);
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

  static Future<void> createToDo(BuildContext context, String userId, String userTodoListTitle, String userTodoListDesc, bool isSwitchedOn) async {
    try {
      final body = jsonEncode(<String, String>{
        'user_todo_list_title': userTodoListTitle.trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_todo_list_desc': userTodoListDesc.trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_todo_list_completed': isSwitchedOn.toString().trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_id': userId,
      });
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

  static Future<void> updateToDo(
    BuildContext context,
    String userTodoListId,
    String userTodoListTitle,
    String userTodoListDesc,
    bool isSwitchedOn,
    String userId,
  ) async {
    try {
      final body = jsonEncode({
        'user_todo_list_id': userTodoListId,
        'user_todo_list_title': userTodoListTitle.replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_todo_list_desc': userTodoListDesc.replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_todo_list_completed': isSwitchedOn.toString(),
        'user_id': userId,
      });

      final response = await http.post(Uri.parse('$apiUrl/update_todo'), headers: apiHeaders, body: body);

      if (response.statusCode == 200) {
        final responseData = response.body;
        try {
          final Map<String, dynamic> data = jsonDecode(responseData);
          Get.offAll(TodoListScreen());
        } catch (e) {
          if (response.body == 'OK') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ToDo created successfully')));
            Get.offAll(TodoListScreen());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An unexpected error occurred.')));
          }
        }
      } else {
        ModalsHelper.showSnackBar(context, 'Failed to update ToDo');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }
}
