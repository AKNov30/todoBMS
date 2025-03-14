import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/models/lists.dart';
import 'package:myproject/screen/addtodo.dart';
import 'package:myproject/screen/edittodo.dart';
// import 'package:hexcolor/hexcolor.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  void showSignOutModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 200, // Set your desired height
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIGN OUT",
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Do you want to log out?",
                  style: GoogleFonts.outfit(fontSize: 16),
                ),
                SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    // print("log out");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/Icon Logut.png",
                            width: 24,
                            height: 24,
                          ),
                          Text(
                            "  Sign out",
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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

  void showEditModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 200, // Set your desired height
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => const Edittodo()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/Icon Edit.png",
                            width: 24,
                            height: 24,
                          ),
                          Text(
                            "  Edit",
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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
                    // print("log out");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/Icon Trash.png",
                            width: 24,
                            height: 24,
                          ),
                          Text(
                            "  Delete",
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "amonAS",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff53CD9F),
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    onTap: () {
                      showSignOutModal();
                    },
                    child: Container(
                      // padding: EdgeInsets.all(10),
                      child: Text(
                        "A",
                        style: TextStyle(color: Color(0xff53CD9F)),
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello!",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    "Amon Kuwana",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    // maxLength: 20,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      labelText: "Search...",
                    ),
                  ),
                  // SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.fromLTRB(0, 10, 10, 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Radio(
                                value: index,
                                groupValue: 0,
                                onChanged: (value) {},
                                activeColor: Color(0xff0D7A5C),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data[index].title,
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xff0D7A5C),
                                            ),
                                            softWrap: true,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            showEditModal();
                                          },
                                          child: Text("..."),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "10:19 AM - 10/20/23",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xffD9D9D9),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      data[index].description,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const Addtodo()),
                  );
                },
                child: Image.asset(
                  'assets/images/Icon Button Add.png',
                  width: 66,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
