import 'package:flutter/material.dart';
import 'package:notes_app/sqldb.dart';
import 'package:sqflite/sqflite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  Sqldb sqldb = Sqldb();
  Future<List<Map>> readData() async {

    List<Map> response = await sqldb.readData("SELECT * FROM notes ");
           notes.addAll(response);
    if(this.mounted){
   setState(() {
     
   });
    }

    return response;
  }
 @override
void initState() {
  readData() ;
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Simple Homepage'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(7),
        child: ListView(
          children: [
             ListView.builder(
                    itemCount: notes.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text("${ notes[index]['title']}"),
                          subtitle: Text("${ notes[index]['note']}"),
                          trailing:IconButton(onPressed: ()async{
                             int response = await sqldb.deleteData("DELETE  FROM notes WHERE id = ${ notes[index]['id']}");
                              if(response > 0 ){
                                notes.removeWhere((element)=>element['id'] ==  notes[index]['id']);
                                setState(() {
                                  
                                });
                              }
                          }, icon:Icon(Icons.delete),color: Colors.red,)
                        ),
                      );
                    },
                  ),
            MaterialButton(
              onPressed: () {
                sqldb.MydeletDatabase();
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("delete data"),
            ),
          ],
        ),
      ),
    );
  }
}
