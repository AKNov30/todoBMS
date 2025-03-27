import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/models/todo_model.dart';
import 'package:myproject/screen/add_to_do_screen.dart';
import 'package:myproject/screen/todolist_screen.dart';
import 'package:myproject/service/todo_service.dart';

class ModalsHelper {
  static void showSignOutModal(BuildContext context, Function onLogout) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("SIGN OUT", style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Do you want to log out?", style: GoogleFonts.outfit(fontSize: 16)),
                const SizedBox(height: 25),
                InkWell(
                  onTap: () => onLogout(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/icon_logout.png", width: 24, height: 24),
                          Text("  Sign out", style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Image.asset("assets/images/icon_arrow2.png"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showEditModal(
    BuildContext context,
    TodoModel todo,
    // Function onProcess
  ) {
    print("456789 ${todo.userId}");
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => AddToDoScreen(todo: todo));
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/icon_edit.png", width: 24, height: 24),
                          Text("  Edit", style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Image.asset("assets/images/icon_arrow2.png"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                  onTap: () {
                    showConfirmDeleteDialog(context, todo.userTodoListId ?? 0);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/images/icon_trash.png", width: 24, height: 24),
                          Text("  Delete", style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Image.asset("assets/images/icon_arrow2.png"),
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

  static Future<void> showConfirmDeleteDialog(BuildContext context, int todoId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this to-do list?'),
          actions: <Widget>[
            TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                await ToDoService.deleteToDoListById(context, todoId);
                Get
                  ..back()
                  ..back();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message), duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
