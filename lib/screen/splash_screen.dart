import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myproject/screen/signin_screen.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    bool? isLogged = prefs.getBool('is_logged_in');

    await Future.delayed(Duration(seconds: 2));

    if (userId != null && isLogged == true) {
      // Navigator.pushReplacementNamed(context, '/to_do_list');
      Get.off(TodoListScreen());
    } else {
      // Navigator.pushReplacementNamed(context, '/sign_in');
      Get.off(SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
