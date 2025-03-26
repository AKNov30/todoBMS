import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/controller/user_getx.controller.dart';
import 'package:myproject/screen/signup_screen.dart';
import 'package:myproject/service/signin_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final UserGetxController userGetxController = Get.put(UserGetxController());
  bool passwordVisible = true;
  final formkey = GlobalKey<FormState>();
  final userEmailController = TextEditingController();
  final userPasswordController = TextEditingController();

  Future<void> signIn(String email, String password) async {
    await SignInService.signIn(context, email, password);
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
                        children: [
                          SizedBox(height: 35),
                          Text("SIGN IN", style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w500)),
                          SizedBox(height: 20),
                          Text("Please enter the information \n           below to access.", style: GoogleFonts.outfit(fontSize: 16)),
                          SizedBox(height: 25),
                          Image.asset("assets/images/icon_signin.png", width: 98, height: 98),
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
                                      controller: userEmailController,
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
                                      controller: userPasswordController,
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
                                      // onEditingComplete: () async {
                                      //   if (formkey.currentState!.validate()) {
                                      //     await userGetxController.signIn(context, userEmailController.text, userPasswordController.text);
                                      //   }
                                      // },
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
                                      onTap: () async {
                                        if (formkey.currentState!.validate()) {
                                          await userGetxController.signIn(context, userEmailController.text, userPasswordController.text);
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
