import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todolist.dart'; // หน้า Todolist
import 'signin.dart'; // หน้า Signin

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

    // ใช้เวลาหนึ่งช่วงในการแสดง splash screen
    await Future.delayed(Duration(seconds: 2));

    // หากมี userId แสดงว่าผู้ใช้ล็อกอินแล้ว
    if (userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Todolist()),
      );
    } else {
      // หากยังไม่ได้ล็อกอิน พาไปหน้า Signin
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Signin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // ใช้เวลาสักครู่ในระหว่างการโหลด
      ),
    );
  }
}
