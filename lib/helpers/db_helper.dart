import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'dart:io' as io;


class DBHelper {
  static sql.Database? _db;
  static const String DB_NAME = 'Dot';

  Future<sql.Database?> get db async {
    if(_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  initDB() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String dbPath = path.join(documentsDirectory.path, DB_NAME);
    var db = await sql.openDatabase(dbPath, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(sql.Database db, int version) async{
    await db.execute('''CREATE TABLE cart(id TEXT PRIMARY KEY)''');
    await  db.execute('''CREATE TABLE wishlist(id TEXT PRIMARY KEY)''');
    await  db.execute('''CREATE TABLE viewed(id TEXT PRIMARY KEY)''');
  }

  Future<void> insert(String table,Map<String, Object> data) async{
    var dbClient = await db;
    await dbClient!.insert(table, data);
  }

  Future<List<Map>> getData(String table) async{
    var dbClient = await db;
    return dbClient!.query(table);
  }

  Future<void> deleteRow(String table, String id) async{
    var dbClient = await db;
    await dbClient!.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateRow(String table, String id, Map<String, dynamic> newData) async{
    var dbClient = await db;
    await dbClient!.update(
        table,
        newData,
        where: 'id = ?',
        whereArgs: [id]
    );
  }

}