import 'package:flutter/material.dart';
import 'package:myproject/screen/signin.dart';
import 'package:myproject/screen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "my flutter",
      home: Scaffold(body: SplashScreen()),
    );
  }
}
