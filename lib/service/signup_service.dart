import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myproject/constant/db.dart';
import 'package:myproject/utility/modals.dart';

class SignUpService {
  static Future<void> signUp(BuildContext context, String email, String password, String userFname, String userLname) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/login'),
        headers: apiHeaders,
        body: jsonEncode(<String, String>{'user_fname': userFname, 'user_lname': userLname, 'user_email': email, 'user_password': password}),
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (response.statusCode == 400 && response.body == '{"message":"This e-mail has already been used.."}') {
        ModalsHelper.showSnackBar(context, response.body);
      } else {
        ModalsHelper.showSnackBar(context, 'Failed to sign up');
      }
    } catch (e) {
      print('An error occurred: $e');
      ModalsHelper.showSnackBar(context, 'An error occurred: $e');
    }
  }
}
