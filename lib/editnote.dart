import 'package:flutter/material.dart';
import 'package:notes_app/home.dart';
import 'package:notes_app/sqldb.dart';

class Editnote extends StatefulWidget {
  final color;
  final title;
  final note;
  final id;

  const Editnote({super.key, this.color, this.title, this.note, this.id});

  @override
  State<Editnote> createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {
  Sqldb sqldb = Sqldb();
  GlobalKey<FormState> globalKey = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  void initState() {
    super.initState();
    title.text = widget.title;
    note.text = widget.note;
    color.text = widget.color;

  }

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
                        int response = await sqldb.updateData('''
                      UPDATE  notes SET 
                      note  = "${note.text}",
                      title ="${title.text}" ,
                      color = "${color.text}"
                      WHERE id = "${widget.id}"
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
