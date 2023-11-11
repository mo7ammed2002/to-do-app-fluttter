import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mohammed.db');
    Database database = await openDatabase(path,
        version: 8, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
      CREATE TABLE "notes"(
       "id"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "note" TEXT NOT NULL, 
      "color" TEXT NOT NULL,
      "title" TEXT NOT NULL

      )

    ''');
    await batch.commit();
    print('create database and table========= ');
  }

  _onUpgrade(Database? db, int oldVersion, int newVersion) async {
    print('onUpgrade=========');
    await db?.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  }

  readData(String sql) async {
    final Database? mydb = await db;
    List<Map<String, Object?>> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    final Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    final Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    final Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  mydeleteDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mohammed.db');
    await deleteDatabase(path);
  }
}
