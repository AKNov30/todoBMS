import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:myproject/models/lists_model.dart';
import 'package:myproject/screen/addtodo_screen.dart';
import 'package:myproject/screen/edittodo_screen.dart';
import 'package:myproject/screen/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  String apiUrl = dotenv.env['api_url'] ?? 'Not Found';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  int? userId;
  String firstName = '';
  String lastName = '';
  List<Lists> todoList = [];
  final searchController = TextEditingController();
  List<Lists> filteredTodoList = [];
  bool noData = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    searchController.addListener(_filterTodos);
  }

  void _filterTodos() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredTodoList =
          todoList.where((todo) {
            return todo.listTitle.toLowerCase().contains(query) || todo.listDesc.toLowerCase().contains(query);
          }).toList();
    });
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
    });
    _fetchTodo();
  }

  Future<void> _fetchTodo() async {
    final url = Uri.parse('$apiUrl/api/todo_list/$userId');
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676'};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      if (responseData.isEmpty) {
        setState(() {
          todoList = [];
        });
        noData = true;
      } else {
        setState(() {
          todoList = responseData.map((data) => Lists.fromJson(data)).toList().reversed.toList();
        });
      }
    } else {
      showSnackBar("Fail");
    }
  }

  Future<void> _deleteTodo(int listId) async {
    final url = Uri.parse('$apiUrl/api/delete_todo/$listId');
    final headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676'};

    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      showSnackBar("Deleted successfully");
      setState(() {
        todoList.removeWhere((todo) => todo.listId == listId);
      });
    } else {
      showSnackBar("Failed to delete");
    }
  }

  List<Color> colorList = [
    Color(0xff0D7A5C),
    Color(0xffFB9A2B),
    Color(0xff355389),
    Color(0xffF7A491),
    Color(0xff3CB189),
    Color.fromARGB(255, 160, 13, 62),
    Color.fromARGB(255, 30, 11, 114),
  ];
  Color randomColor() {
    Random random = Random();
    return colorList[random.nextInt(colorList.length)];
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Signin()), (route) => false);
    Get.offAll(Signin());
  }

  void showSignOutModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SIGN OUT", style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Do you want to log out?", style: GoogleFonts.outfit(fontSize: 16)),
                SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    _logout();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/Icon Logut.png", width: 24, height: 24),
                          Text("  Sign out", style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Image.asset("assets/images/Icon Arrow2.png"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  void showEditModal(int listId, String listTitle, String listDesc, bool listCompleted) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Edittodo(listId: listId, listTitle: listTitle, listDesc: listDesc, listCompleted: listCompleted),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/Icon Edit.png", width: 24, height: 24),
                          Text("  Edit", style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Image.asset("assets/images/Icon Arrow2.png"),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                InkWell(
                  onTap: () {
                    showConfirmDeleteDialog(listId);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/Icon Trash.png", width: 24, height: 24),
                          Text("  Delete", style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Image.asset("assets/images/Icon Arrow2.png"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showConfirmDeleteDialog(int listId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this to do list?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Navigator.pop(context);
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteTodo(listId);
                // Navigator.pop(context);
                // Navigator.pop(context);
                Get.back();
                Get.back();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message), duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String maxText(String text, int maxLength) {
    return text.length > maxLength ? '${text.substring(0, maxLength)}...' : text;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          // toolbarHeight: 82.0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff4CC599), Color(0xff0D7A5C)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: InkWell(
                    onTap: () {
                      showSignOutModal();
                    },
                    child: Text(
                      firstName[0], // ตัวอักษรแรกของชื่อ
                      style: TextStyle(
                        color: Color(0xff53CD9F), // สีของตัวอักษร
                        fontSize: 18, // ขนาดตัวอักษร
                        fontWeight: FontWeight.bold, // ทำให้ตัวอักษรหนา
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  showSignOutModal();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello!", style: GoogleFonts.outfit(fontSize: 12, color: Colors.white)),
                    Text(
                      maxText("$firstName $lastName", 15),
                      // "$firstName $lastName",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshTodo,
          child: ListView(
            shrinkWrap: true, // ให้ ListView ปรับขนาดตามเนื้อหา
            physics: AlwaysScrollableScrollPhysics(), // ให้เลื่อนได้เสมอ
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                      labelText: "Search...",
                    ),
                  ),
                ),
              ),
              noData
                  ? Center(child: Text("ยังไม่มีข้อมูล"))
                  : filteredTodoList.isEmpty && searchController.text.isNotEmpty
                  ? Center(child: Text("ไม่พบข้อมูล", style: TextStyle(fontSize: 16, color: Colors.grey)))
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // ป้องกันการเลื่อนซ้อน
                    itemCount: filteredTodoList.isEmpty && searchController.text.isEmpty ? todoList.length : filteredTodoList.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodoList.isEmpty && searchController.text.isEmpty ? todoList[index] : filteredTodoList[index];
                      DateTime utcDateTime = todo.lastUpdate.toUtc();
                      DateTime thailandTime = utcDateTime.add(Duration(hours: 7));
                      String formattedDate = DateFormat('hh:mm a - MM/dd/yy').format(thailandTime);
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          height: 140,
                          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                    child: InkWell(child: Image.asset(todo.listCompleted ? "assets/images/Check.png" : "assets/images/unCheck.png")),
                                  ),
                                  SizedBox(),
                                  SizedBox(),
                                  SizedBox(),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          maxText(todo.listTitle, 20),
                                          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.w500, color: randomColor()),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            showEditModal(todo.listId, todo.listTitle, todo.listDesc, todo.listCompleted);
                                          },
                                          child: Text("..."),
                                        ),
                                      ],
                                    ),
                                    Text(formattedDate, style: TextStyle(fontSize: 12, color: Color(0xffD9D9D9))),
                                    SizedBox(height: 5),
                                    Text(
                                      todo.listDesc,
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/add_to_do');
            Get.to(Addtodo());
          },
          child: Image.asset('assets/images/Icon Button Add.png', width: 66),
        ),
      ),
    );
  }

  Future<void> _refreshTodo() async {
    setState(() {
      _fetchTodo();
    });
  }
}
