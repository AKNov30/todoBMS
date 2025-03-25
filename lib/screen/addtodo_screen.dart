// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:myproject/screen/todolist_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Addtodo extends StatefulWidget {
//   const Addtodo({super.key});

//   @override
//   State<Addtodo> createState() => _AddtodoState();
// }

// class _AddtodoState extends State<Addtodo> {
//   String apiUrl = dotenv.env['api_url'] ?? 'Not Found';
//   int? userId;
//   final formkey = GlobalKey<FormState>();
//   final todotitle = TextEditingController();
//   final tododescription = TextEditingController();
//   bool isCompleted = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserId();
//   }

//   Future<int?> _loadUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userId = prefs.getInt('userId');
//     });
//   }

//   Future<void> _submittodo() async {
//     final url = Uri.parse('$apiUrl/create_todo');
//     final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676'};
//     final body = jsonEncode({
//       "user_todo_type_id": 1,
//       "user_todo_list_title": todotitle.text.trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
//       "user_todo_list_desc": tododescription.text.trim().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
//       "user_todo_list_completed": isCompleted.toString().replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), ''),
//       "user_id": userId,
//     });

//     final response = await http.post(url, headers: headers, body: body);
//     if (response.statusCode == 200) {
//       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Todolist()), (Route<dynamic> route) => false);
//       Get.offAll(Todolist());
//       showSnackBar("Create Todo Completed");
//     } else {
//       showSnackBar("fail");
//     }
//   }

//   void showSnackBar(String message) {
//     final snackBar = SnackBar(content: Text(message), duration: const Duration(seconds: 2));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(colors: [Color(0xff4CC599), Color(0xff0D7A5C)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//             ),
//           ),
//           title: Row(
//             children: [
//               TextButton(
//                 onPressed: () {
//                   Get.back();
//                   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Todolist()));
//                 },
//                 child: Image.asset("assets/images/ICon Arrowleft.png", color: Colors.white),
//               ),
//               Text("Add Your Todo", style: GoogleFonts.outfit(fontSize: 20, color: Colors.white)),
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(15),
//             child: Form(
//               key: formkey,
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xffffffff),
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                       boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
//                     ),
//                     child: TextFormField(
//                       controller: todotitle,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
//                         label: Text("Title", style: GoogleFonts.outfit(fontSize: 15)),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter title';
//                         }
//                         return null;
//                       },
//                       textInputAction: TextInputAction.next,
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xffffffff),
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                       boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
//                     ),
//                     child: TextFormField(
//                       controller: tododescription,
//                       maxLength: 250,
//                       maxLines: 5,
//                       keyboardType: TextInputType.multiline,
//                       decoration: InputDecoration(
//                         alignLabelWithHint: true,
//                         border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
//                         label: Text("Description", style: GoogleFonts.outfit(fontSize: 15)),
//                       ),
//                       onEditingComplete: () {
//                         if (formkey.currentState!.validate()) {
//                           _submittodo();
//                         }
//                       },
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter title';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 15),
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Color(0xffffffff),
//                       borderRadius: BorderRadius.all(Radius.circular(15)),
//                       boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Success", style: GoogleFonts.outfit(color: Color(0xff0D7A5C), fontWeight: FontWeight.w500)),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               isCompleted = !isCompleted;
//                             });
//                           },
//                           child: Image.asset(isCompleted ? 'assets/images/switch_on.png' : 'assets/images/switch_off.png', width: 50, height: 50),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: GestureDetector(
//                       onTap: () {
//                         if (formkey.currentState!.validate()) {
//                           _submittodo();
//                         }
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           gradient: LinearGradient(
//                             colors: [Color(0xff53CD9F), Color(0xff0D7A5C)],
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                           ),
//                         ),
//                         child: Center(child: Text("SAVE", style: GoogleFonts.outfit(fontSize: 18, color: Colors.white))),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
