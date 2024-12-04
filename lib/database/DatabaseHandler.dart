import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static Future<Database> initDB() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'medicament_database.db'),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE medicaments(
              id INTEGER PRIMARY KEY, 
              name TEXT, 
              time TEXT, 
              frequency TEXT,
              amountLeft INTEGER,
              prescriptionTime TEXT,
              )''');
      },
      version: 1,
    );
    return database;
  }
}