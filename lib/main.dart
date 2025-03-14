import 'package:flutter/material.dart';
import 'package:myproject/screen/signin.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "my flutter", home: Scaffold(body: Signin()));
  }
}
