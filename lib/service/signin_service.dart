import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myproject/constant/db.dart';
import 'package:myproject/models/user_model.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:myproject/utility/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInService {
  static Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: apiHeaders,
        body: jsonEncode(<String, String>{'user_email': email, 'user_password': password}),
      );
      inspect(response);
      final message = jsonDecode(response.body);
      print(message["message"]);
      if (response.statusCode == 200) {
        final UserModel user = userModelFromJson(response.body);

        if (user.userId != null && user.userEmail.isNotEmpty && user.userFname.isNotEmpty && user.userLname.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('userId', user.userId);
          await prefs.setString('userEmail', user.userEmail);
          await prefs.setString('userFname', user.userFname);
          await prefs.setString('userLname', user.userLname);

          Get.off(TodoListScreen());
        } else {
          ModalsHelper.showSnackBar(context, "Invalid response from server");
        }
      } else if (response.statusCode == 400 && response.body == '{"message":"Email or password is incorrect."}') {
        ModalsHelper.showSnackBar(context, "Email or password is incorrect.");
      } else {
        print('Failed to sign in: ${response.statusCode}');
        ModalsHelper.showSnackBar(context, 'Failed to sign in: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }
}
