import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/controller/user_getx.controller.dart';
import 'package:myproject/models/todo_model.dart';
import 'package:myproject/screen/add_to_do_screen.dart';
import 'package:myproject/screen/signin_screen.dart';
import 'package:myproject/service/todo_service.dart';
import 'package:myproject/utility/color_list.dart';
import 'package:myproject/utility/format_date.dart';
import 'package:myproject/utility/modals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  int? userId;
  String firstName = '';
  String lastName = '';
  final searchController = TextEditingController();
  late Future<List<TodoModel>> _allTodos;
  List<TodoModel> _filteredTodos = [];
  bool _isSearching = false;
  // final UserGetxController userGetxController = Get.put(UserGetxController());

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
      firstName = prefs.getString('userFname') ?? '';
      lastName = prefs.getString('userLname') ?? '';
    });
    if (userId != null) {
      setState(() {
        getToDoListById();
      });
    }
  }

  Future<void> getToDoListById() async {
    setState(() {
      _allTodos = ToDoService.getToDoListById(context, userId!);
    });
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.delete<UserGetxController>();
    Get.offAll(SignInScreen());
  }

  void _searchTodos(String query, List<TodoModel> todos) {
    setState(() {
      _isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        _filteredTodos = [];
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredTodos =
            todos.where((todo) {
              return todo.userTodoListTitle!.toLowerCase().contains(lowerQuery) || todo.userTodoListDesc!.toLowerCase().contains(lowerQuery);
            }).toList();
      }
    });
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
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xff4CC599), Color(0xff0D7A5C)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
          title: Row(
            children: [
              InkWell(
                onTap: () => ModalsHelper.showSignOutModal(context, _logOut),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Text(
                      '${firstName[0].toUpperCase()}',
                      style: TextStyle(color: Color(0xff53CD9F), fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ModalsHelper.showSignOutModal(context, _logOut);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello!", style: GoogleFonts.outfit(fontSize: 12, color: Colors.white)),
                    Text(maxText("$firstName $lastName", 15), style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),

        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: getToDoListById,
          child: FutureBuilder<List<TodoModel>>(
            future: _allTodos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No todos found'));
              } else {
                final todos = snapshot.data!;
                final displayTodos = _isSearching ? _filteredTodos : todos;

                return Column(
                  children: [
                    // Search Box
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: const Offset(0, 1))],
                        ),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon:
                                _isSearching
                                    ? IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        searchController.clear();
                                        _searchTodos('', todos);
                                      },
                                    )
                                    : null,
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                            labelText: "Search...",
                          ),
                          onChanged: (value) {
                            _searchTodos(value, todos);
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child:
                          displayTodos.isEmpty && _isSearching
                              ? Center(child: Text('No results found'))
                              : ListView.builder(
                                itemCount: displayTodos.length,
                                itemBuilder: (context, index) {
                                  final todo = displayTodos[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Container(
                                      height: 140,
                                      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: const Offset(0, 1)),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                                child: InkWell(
                                                  onTap: () {
                                                    // สามารถเพิ่มการ toggle สถานะ completed ได้ที่นี่
                                                  },
                                                  child: Image.asset(
                                                    todo.userTodoListCompleted == "true" ? "assets/images/check.png" : "assets/images/un_check.png",
                                                  ),
                                                ),
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
                                                    Expanded(
                                                      child: Text(
                                                        todo.userTodoListTitle ?? '',
                                                        style: GoogleFonts.outfit(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: ColorUtil.getRandomColor(),
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        // print("aas $todo.userId}");
                                                        await ModalsHelper.showEditModal(context, todo);
                                                        await getToDoListById();
                                                      },
                                                      child: const Text("..."),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  DateUtil.formatDate(todo.userTodoListLastUpdate ?? DateTime.now()),
                                                  style: const TextStyle(fontSize: 12, color: Color(0xffD9D9D9)),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  todo.userTodoListDesc ?? '',
                                                  style: const TextStyle(fontSize: 12, color: Colors.black),
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
                    ),
                  ],
                );
              }
            },
          ),
        ),
        floatingActionButton: RawMaterialButton(
          onPressed: () {
            if (userId != null) {
              Get.to(AddToDoScreen(userId: userId!))?.then((_) {
                getToDoListById();
              });
            } else {
              ModalsHelper.showSnackBar(context, 'User ID is missing');
            }
          },
          child: Image.asset('assets/images/icon_button_add.png', width: 66),
        ),
      ),
    );
  }
}
