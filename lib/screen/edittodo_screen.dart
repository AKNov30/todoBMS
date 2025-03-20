import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/screen/todolist_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edittodo extends StatefulWidget {
  final int listId;
  final String listTitle;
  final String listDesc;
  final bool listCompleted;

  const Edittodo({
    Key? key,
    required this.listId,
    required this.listTitle,
    required this.listDesc,
    required this.listCompleted,
  }) : super(key: key);

  @override
  State<Edittodo> createState() => _EdittodoState();
}

class _EdittodoState extends State<Edittodo> {
  String apiUrl = dotenv.env['api_url'] ?? 'Not Found';
  final formkey = GlobalKey<FormState>();
  final todotitle = TextEditingController();
  final tododescription = TextEditingController();
  int? listId;
  int? userId;
  bool isCompleted = false;

  @override
  void initState() {
    todotitle.text = widget.listTitle;
    tododescription.text = widget.listDesc;
    isCompleted = widget.listCompleted;

    _loadUserId();
  }

  Future<int?> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
    });
  }

  Future<void> _updateTodo() async {
    final url = Uri.parse('$apiUrl/api/update_todo');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
    };

    final body = jsonEncode({
      "user_todo_list_id": widget.listId,
      'user_todo_list_title': todotitle.text.trim(),
      'user_todo_list_desc': tododescription.text.trim(),
      'user_todo_type_id': 1,
      'user_todo_list_completed': isCompleted.toString(),
      "user_id": userId,
    });

    final response = await http.post(url, headers: headers, body: body);
    print(body);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Todolist()),
        (Route<dynamic> route) => false,
      );
      showSnackBar("Edit Todo Completed ${response.body}");
    } else {
      showSnackBar("fail");
    }
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff4CC599), Color(0xff0D7A5C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/images/ICon Arrowleft.png",
                  color: Colors.white,
                ),
              ),
              Text(
                "Edit Your Todo",
                style: GoogleFonts.outfit(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              child: Column(
                children: [
                  Text("ID: ${widget.listId}"),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: todotitle,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            label: Text(
                              "Title",
                              style: GoogleFonts.outfit(fontSize: 15),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: tododescription,
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            label: Text(
                              "Description",
                              style: GoogleFonts.outfit(fontSize: 15),
                            ),
                          ),
                          onEditingComplete: () {
                            if (formkey.currentState!.validate()) {
                              _updateTodo();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Success",
                              style: GoogleFonts.outfit(
                                color: Color(0xff0D7A5C),
                              ),
                            ),
                            // Switch(
                            //   value: isCompleted,
                            //   activeColor: Color(0xff3CB189),
                            //   onChanged: ((value) {
                            //     setState(() {
                            //       isCompleted = value;
                            //     });
                            //   }),
                            // ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isCompleted = !isCompleted;
                                });
                              },
                              child: Image.asset(
                                isCompleted
                                    ? 'assets/images/switch_on.png'
                                    : 'assets/images/switch_off.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      // Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            _updateTodo();
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
                            child: Center(
                              child: Text(
                                "SAVE",
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
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
      ),
    );
  }
}
