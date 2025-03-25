import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
                          Image.asset("assets/images/Icon Logut.png", width: 24, height: 24),
                          Text("  Sign out", style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      Image.asset("assets/images/Icon Arrow2.png"),
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

  static void showEditModal(
    BuildContext context,
    int listId,
    String listTitle,
    String listDesc,
    String listCompleted,
    Function onEdit,
    Function onDelete,
  ) {
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
                InkWell(
                  onTap: () => onEdit(),
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
                const SizedBox(height: 10),
                const Divider(),
                InkWell(
                  onTap: () => onDelete(),
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

  static void showConfirmDeleteDialog(BuildContext context, Function onDelete) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this to-do list?'),
          actions: <Widget>[
            TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                onDelete();
                Get.back(); // ปิด Dialog
                Get.back(); // ปิด Modal
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
