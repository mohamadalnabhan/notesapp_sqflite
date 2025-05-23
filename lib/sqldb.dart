import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class Sqldb {
static Database? _db ; 

Future<Database?> get db async {
  if(_db == null){
    _db = await initialDb();
     return  _db ;
  }else{
    return _db ;
  }
}


initialDb() async {
 String databasepath = await getDatabasesPath();
 String path = join(databasepath,"mohamad.db");
 Database database = await openDatabase(path , onCreate: _onCreate , version: 1 ,onUpgrade:_onUpgrade ) ;

 _onUpgrade(Database db , int oldVer , int newVer){

 }
}
_onCreate(Database  db , int version)async {
  await db.execute('''
  CREATE TABLE "notes"( id INTEGER PRIMARY KEY NOT NULL AUTOINCREMENT ,
  notes TEXT )

''');

}
readData(String sql) async {
Database? mydb = await db ;
var response = await mydb!.rawInsert(sql);
}
insertData(String sql) async {
Database? mydb = await db ;
var response = await mydb!.rawInsert(sql);
}
updateData(String sql) async {
Database? mydb = await db ;
var response = await mydb!.rawUpdate(sql);
}
deleteData(String sql) async {
Database? mydb = await db ;
var response = await mydb!.rawDelete(sql);
}


}