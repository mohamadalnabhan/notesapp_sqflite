import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;

 Future<Database> get db async {
  if (_db == null) {
    _db = await initialDb();
  }
  return _db!;
}


  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "mohamad.db");
    Database database = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
    return database ;
  print(" on upgrade======") ;
    
  }
  _onUpgrade(Database db, int oldVer, int newVer) {
    
    }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "notes" ( 
  "id" INTEGER NOT NULL PRIMARY KEY  AUTOINCREMENT ,
  "note" TEXT NOT NULL)

''');
  print(" on create======") ;
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response ;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
     return response ;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
     return response ;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
     return response ;
  }
}
MydeletDatabase()async{
   String databasepath = await getDatabasesPath();
    String path = join(databasepath, "mohamad.db");

  return deleteDatabase(path);
}