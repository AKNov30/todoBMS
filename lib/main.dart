import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myproject/dependency_injection.dart';
import 'package:myproject/screen/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "my flutter",
      home: SplashScreen(),
      // routes: {
      //   '/sign_in': (context) => Signin(),
      //   '/sign_up': (context) => Signup(),
      //   '/to_do_list': (context) => Todolist(),
      //   '/add_to_do': (context) => Addtodo(),
      // },
    );
  }
}
