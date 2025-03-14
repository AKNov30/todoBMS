import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/screen/todolist.dart';

class Edittodo extends StatefulWidget {
  const Edittodo({super.key});

  @override
  State<Edittodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Edittodo> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "amonAS",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff53CD9F),
          title: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (ctx) => const Todolist()),
                  );
                },
                child: Image.asset("assets/images/ICon Arrowleft.png"),
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
                  TextFormField(
                    // maxLength: 20,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      label: Text(
                        "Title",
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    // maxLength: 20,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      // labelText: "Description",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      label: Text(
                        "Description",
                        style: GoogleFonts.outfit(fontSize: 15),
                      ),
                      // contentPadding: EdgeInsets.symmetric(vertical: 20),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Success",
                          style: GoogleFonts.outfit(color: Color(0xff0D7A5C)),
                        ),
                        Switch(
                          value: isSwitched,
                          activeColor: Color(0xff3CB189),
                          onChanged: ((value) {
                            setState(() {
                              isSwitched = value;
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff53CD9F),
                        padding: EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "SAVE",
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          color: Colors.white,
                        ),
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
