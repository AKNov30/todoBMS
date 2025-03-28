import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/models/todo_model.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:myproject/service/todo_service.dart';

class AddToDoScreen extends StatefulWidget {
  final int? userId;
  final TodoModel? todo;
  const AddToDoScreen({super.key, this.userId, this.todo});
  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final formkey = GlobalKey<FormState>();
  final todotitle = TextEditingController();
  final tododescription = TextEditingController();
  bool isSwitchedOn = false;

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      todotitle.text = widget.todo!.userTodoListTitle ?? '';
      tododescription.text = widget.todo!.userTodoListDesc ?? '';
      isSwitchedOn = widget.todo!.userTodoListCompleted == 'true' ? true : false;
      print("hi edi to do");
    } else {
      print("hi add to do");
    }
  }

  Future<void> _postToDo() async {
    TodoModel itemTodo = TodoModel();
    itemTodo.userTodoListTitle = todotitle.text;
    itemTodo.userTodoListDesc = tododescription.text;
    itemTodo.userTodoListCompleted = isSwitchedOn.toString();
    if (widget.todo == null) {
      itemTodo.userId = widget.userId;
      ToDoService.createToDo(context, itemTodo);
    } else {
      itemTodo.userId = widget.todo?.userId;
      itemTodo.userTodoListId = widget.todo?.userTodoListId;
      print("4567");
      await ToDoService.updateToDo(context, itemTodo);
      // Navigator.of(context).pop();
      Get.offAll(() => TodoListScreen());
    }
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
              TextButton(
                onPressed: () {
                  Get.back();
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Todolist()));
                },
                child: Image.asset("assets/images/icon_arrowleft.png", color: Colors.white),
              ),
              Text(widget.todo == null ? "Add Your Todo" : "Your Todo", style: GoogleFonts.outfit(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('USER ID: ${widget.userId}'),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                    ),
                    child: TextFormField(
                      controller: todotitle,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                        label: Text("Title", style: GoogleFonts.outfit(fontSize: 15)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                    ),
                    child: TextFormField(
                      controller: tododescription,
                      maxLength: 250,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                        label: Text("Description", style: GoogleFonts.outfit(fontSize: 15)),
                      ),
                      onEditingComplete: () {
                        if (formkey.currentState!.validate()) {
                          // _submittodo();
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1))],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Success", style: GoogleFonts.outfit(color: Color(0xff0D7A5C), fontWeight: FontWeight.w500)),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSwitchedOn = !isSwitchedOn;
                            });
                          },
                          child: Image.asset(isSwitchedOn ? 'assets/images/switch_on.png' : 'assets/images/switch_off.png', width: 50, height: 50),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          _postToDo();
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
                        child: Center(child: Text("SAVE", style: GoogleFonts.outfit(fontSize: 18, color: Colors.white))),
                      ),
                    ),
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
