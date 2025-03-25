import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myproject/constant/db.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:myproject/utility/modals.dart';

class ToDoService {
  static Future<List<dynamic>> getToDoListById(BuildContext context, String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/todo_list/$userId'),
        headers: apiHeaders,
      );
      if (response.statusCode == 200) {
        List<dynamic> toDoList = jsonDecode(response.body);
        toDoList.sort((a, b) => DateTime.parse(b['user_todo_list_last_update']).compareTo(DateTime.parse(a['user_todo_list_last_update'])));
        return toDoList;
      } else {
        throw Exception('Failed to load to-do list');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
      return [];
    }
  }

  static Future<void> deleteToDoListById(BuildContext context, String todoListId) async {
    try {
      final response = await http.delete(
        Uri.parse('$apiUrl/delete_todo/$todoListId'),
        headers: apiHeaders,
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          ModalsHelper.showSnackBar(context, 'Delete successfully');
        );
      } else {
        throw Exception('Failed to delete to-do list');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }

  static Future<Map<String, dynamic>?> fetchTodoDetails(BuildContext context, String userId, String userTodoListId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/todo_list/$userId'),
        headers: apiHeaders,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        final todoItem = data.firstWhere(
          (item) => item['user_todo_list_id'].toString() == userTodoListId,
          orElse: () => null,
        );

        if (todoItem != null) {
          return todoItem;
        } else {
          print('ToDo item not found');
          return null;
        }
      } else {
        print('Failed to load ToDo details');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<void> createToDo(BuildContext context, String userId, String userFname, String userLname, String userTodoListTitle, String userTodoListDesc, bool isSwitchedOn) async {
    try {
      final body = jsonEncode(<String, String>{
        'user_todo_type_id': '1',
        'user_todo_list_title': userTodoListTitle.trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_todo_list_desc': userTodoListDesc.trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_todo_list_completed': isSwitchedOn.toString().trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
        'user_id': userId,
      });
      final response = await http.post(
        Uri.parse('$apiUrl/create_todo'),
        headers: apiHeaders,
        body: body,
      );
      if (response.statusCode == 200) {
        final responseData = response.body;
        try {
          final Map<String, dynamic> data = jsonDecode(responseData);
          ModalsHelper.showSnackBar(context, 'Create Todo Completed');
          Get.offAll(TodoListScreen());
        } catch (e) {
          if (response.body == 'OK') {
            ModalsHelper.showSnackBar(context, 'Create Todo Completed');
            Get.offAll(TodoListScreen());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              ModalsHelper.showSnackBar(context, 'An unexpected error occurred.');
            );
          }
        }
      } else {
        ModalsHelper.showSnackBar(context, 'Failed to save');
      }
    } catch (e) {
      print('error: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }

  static Future<void> updateToDo(BuildContext context, String userTodoListId, String userTodoListTitle, String userTodoListDesc, bool isSwitchedOn, String userId, String userFname, String userLname) async {
    try {
      final body = jsonEncode({
        'user_todo_list_id': userTodoListId,
        'user_todo_list_title': userTodoListTitle,
        'user_todo_list_desc': userTodoListDesc,
        'user_todo_list_completed': isSwitchedOn.toString(),
        'user_id': userId,
        'user_todo_type_id': '1',
      });

      final response = await http.post(
        Uri.parse('$apiUrl/update_todo'),
        headers: apiHeaders,
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        try {
          final Map<String, dynamic> data = jsonDecode(responseData);
          if (data.containsKey('code') && data['code'] == 'ER_DATA_TOO_LONG') {
            _showErrorDialog(context, 'ข้อมูลยาวเกินไป', 'กรุณาปรับลดความยาวของข้อมูลที่กรอก');
            return;
          }
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ToDoList(userData: data)),
            (Route<dynamic> route) => false,
          );
        } catch (e) {
          if (response.body == 'OK') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('ToDo created successfully')),
            );
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ToDoList(
                  userData: {
                    'user_id': userId,
                    'user_fname': userFname,
                    'user_lname': userLname,
                  },
                ),
              ),
              (Route<dynamic> route) => false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('An unexpected error occurred.')),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update ToDo')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No internet connection')),
      );
    }
  }
}
