import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:myproject/service/signup_service.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool passwordVisible = true;
  final formkey = GlobalKey<FormState>();
  final userFirstname = TextEditingController();
  final userLastname = TextEditingController();
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();

  Future<void> _signup() async {
    final userFname = userFirstname.text;
    final userLname = userLastname.text;
    final email = userEmail.text;
    final password = userPassword.text;
    SignUpService.signUp(context, email, password, userFname, userLname);
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
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Image.asset("assets/images/icon_arrowleft.png"),
                            onPressed: () {
                              // Navigator.pop(context);
                              Get.back();
                            },
                          ),
                          Text("SIGN UP", style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w500)),
                          SizedBox(width: 68),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text("Please enter the information \n           below to access.", style: GoogleFonts.outfit(fontSize: 16)),
                      SizedBox(height: 25),
                      Image.asset("assets/images/icon_signup.png", width: 98, height: 98),
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
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                                ),
                                child: TextFormField(
                                  // maxLength: 20,
                                  controller: userFirstname,
                                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Color(0xffF3F3F3),
                                    label: Text(
                                      "First name",
                                      style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff666161)),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your first name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F3F3),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                                ),
                                child: TextFormField(
                                  // maxLength: 20,
                                  controller: userLastname,
                                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Color(0xffF3F3F3),
                                    label: Text(
                                      "Last name",
                                      style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff666161)),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F3F3),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                                ),
                                child: TextFormField(
                                  controller: userEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  // maxLength: 20,
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
                                    } else if (!EmailValidator.validate(value)) {
                                      return 'Please enter a valid email address';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3F3F3),
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                                ),
                                child: TextFormField(
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
                                    filled: true,
                                    fillColor: Color(0xffF3F3F3),
                                    label: Text(
                                      "Password",
                                      style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xff666161)),
                                    ),
                                  ),
                                  onEditingComplete: () {
                                    if (formkey.currentState!.validate()) {
                                      _signup();
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
                              SizedBox(height: 30),
                              SizedBox(
                                width: double.infinity,
                                child: GestureDetector(
                                  onTap: () {
                                    if (formkey.currentState!.validate()) {
                                      _signup();
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
                                    child: Text("SIGN UP", textAlign: TextAlign.center, style: GoogleFonts.outfit(fontSize: 18, color: Colors.white)),
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
          ],
        ),
      ),
    );
  }
}
