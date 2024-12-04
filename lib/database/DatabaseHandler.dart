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
              dose INTEGER,
              time TEXT, 
              frequency INTEGER,
              amountLeft INTEGER,
              prescriptionTime TEXT,
              )''');
        //für Kalender wäre noch ein Datum nötig
      },
      version: 1,
    );
    return database;
  }
}