import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/models/user.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:myproject/screen/todolist.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey = GlobalKey<FormState>();
  final navigatorKey = GlobalKey<NavigatorState>();
  final userFirstname = TextEditingController();
  final userLastname = TextEditingController();
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "amonAS",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "SIGN UP",
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          // decoration: DecorationImage(image: Image.asset("assets/images/signup.png"),),
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Please enter the information \n           below to access.",
                      style: GoogleFonts.outfit(fontSize: 16),
                    ),
                    SizedBox(height: 25),
                    Image.asset(
                      "assets/images/Ion Signup.png",
                      width: 98,
                      height: 98,
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              // maxLength: 20,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                label: Text(
                                  "First name",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              // maxLength: 20,
                              controller: userLastname,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                label: Text(
                                  "Last name",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              // maxLength: 20,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                label: Text(
                                  "Email",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              obscureText: true,
                              // keyboardType: TextInputType.visiblePassword,
                              // maxLength: 20,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                                label: Text(
                                  "Password",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff00503E),
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
