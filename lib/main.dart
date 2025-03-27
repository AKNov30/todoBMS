import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/dependency_injection.dart';
import 'package:myproject/screen/splash_screen.dart';

void main() async {
  runApp(MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, title: "my flutter", home: SplashScreen());
  }
}
