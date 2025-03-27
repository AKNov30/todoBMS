import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/constant/db.dart';
import 'package:myproject/models/user_model.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:myproject/utility/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserGetxController extends GetxController {
  Rxn<UserModel> user = Rxn<UserModel>();
  Future<void> signIn(BuildContext context, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: apiHeaders,
        body: jsonEncode(<String, dynamic>{'user_email': email, 'user_password': password}),
      );

      if (response.statusCode == 200) {
        user.value = userModelFromJson(response.body);
        print('qq ${user.value?.userId}');
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', user.value?.userId ?? 0);
        await prefs.setBool('is_logged_in', true);
        // Navigator.pushReplacement(context, MaterialPageRoute<void>(builder: (BuildContext context) => const TodoListScreen()));
        Get.off(() => TodoListScreen());
      } else if (response.statusCode == 400) {
        final body = jsonDecode(response.body);
        ModalsHelper.showSnackBar(context, body["message"]);
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }
}
