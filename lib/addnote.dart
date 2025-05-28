import 'package:flutter/material.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/sqldb.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  Sqldb sqldb = Sqldb();
  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("add notes")),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: globalKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: note,
                    decoration: InputDecoration(hintText: "enter ur note"),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: title,
                    decoration: InputDecoration(hintText: "enter ur title"),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: color,
                    decoration: InputDecoration(hintText: "enter the color "),
                  ),
                  const SizedBox(height: 50),
                  MaterialButton(
                    onPressed: () async {
                      try {
                        int response = await sqldb.insertData('''
                      INSERT INTO notes(note, title, color) 
                      VALUES ("${note.text}", "${title.text}", "${color.text}")
                    ''');
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false,
                          );
                        }
                      } catch (e) {
                        print("Error: $e");
                      }
                    },
                    child: Text("Add Note"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
