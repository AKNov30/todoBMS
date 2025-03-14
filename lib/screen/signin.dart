import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screen/signup.dart';
import 'package:myproject/screen/todolist.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "amonAS",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "SIGN IN",
            style: GoogleFonts.outfit(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Please enter the information \n           below to access.",
                        style: GoogleFonts.outfit(fontSize: 16),
                      ),
                      SizedBox(height: 25),
                      Image.asset(
                        "assets/images/Icon Sigin.png",
                        width: 98,
                        height: 98,
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Form(
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
                                    "Email",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              TextFormField(
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  // style: TextButton.styleFrom(),
                                  onPressed: null,
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              SizedBox(height: 40),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff53CD9F),
                                    padding: EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (ctx) => const Todolist(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "SIGN IN",
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
                  Column(
                    children: [
                      SizedBox(height: 15),
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const Signup(),
                              ),
                            );
                          },
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
