import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screen/signup_screen.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String apiUrl = dotenv.env['api_url'] ?? 'Not Found';
  bool passwordVisible = true;
  final formkey = GlobalKey<FormState>();
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();

  Future<void> _signin() async {
    final url = Uri.parse('$apiUrl/api/login');
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676'};
    final body = jsonEncode({'user_email': userEmail.text, 'user_password': userPassword.text});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final userId = jsonResponse['user_id'];
      final firstName = jsonResponse['user_fname'];
      final lastName = jsonResponse['user_lname'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', userId);
      prefs.setString('firstName', firstName);
      prefs.setString('lastName', lastName);
      showSnackBar("Sign In successful");

      // Navigator.pushReplacementNamed(context, '/to_do_list');
      Get.to(Todolist());
    } else {
      showSnackBar("Invalid email or password.");
    }
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message), duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/images/signup.png", fit: BoxFit.cover, width: double.infinity, height: double.infinity),
            SingleChildScrollView(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(height: 35),
                          Text("SIGN IN", style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w500)),
                          SizedBox(height: 20),
                          Text("Please enter the information \n           below to access.", style: GoogleFonts.outfit(fontSize: 16)),
                          SizedBox(height: 25),
                          Image.asset("assets/images/Icon Sigin.png", width: 98, height: 98),
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF3F3F3),
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1)),
                                      ],
                                    ),
                                    child: TextFormField(
                                      // maxLength: 20,
                                      controller: userEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: Color(0xffF3F3F3),
                                        label: Text(
                                          "Email",
                                          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff666161)),
                                        ),
                                      ),
                                      textInputAction: TextInputAction.next,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF3F3F3),
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1)),
                                      ],
                                    ),
                                    child: TextFormField(
                                      // maxLength: 20,
                                      controller: userPassword,
                                      obscureText: passwordVisible,
                                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                                        suffixIcon: IconButton(
                                          icon: Icon(passwordVisible ? Icons.visibility_off : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              passwordVisible = !passwordVisible;
                                            });
                                          },
                                        ),
                                        label: Text(
                                          "Password",
                                          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff666161)),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xffF3F3F3),
                                      ),
                                      onEditingComplete: () {
                                        if (formkey.currentState!.validate()) {
                                          _signin();
                                        }
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      // style: TextButton.styleFrom(),
                                      onPressed: null,
                                      child: Text(
                                        "Forgot Password?",
                                        style: GoogleFonts.outfit(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40),
                                  SizedBox(
                                    width: double.infinity,
                                    child: GestureDetector(
                                      onTap: () {
                                        if (formkey.currentState!.validate()) {
                                          _signin();
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            colors: [Color(0xff53CD9F), Color(0xff0D7A5C)],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                        child: Text(
                                          "SIGN IN",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
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
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (ctx) => const Signup()));
                                Get.to(Signup());
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [Color(0xff0D7A5C), Color(0xff00503E)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Text(
                                  "SIGN UP",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                                ),
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
          ],
        ),
      ),
    );
  }
}
