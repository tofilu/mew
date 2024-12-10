import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:path/path.dart';

import '../Helper/Drug.dart';

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
              prescriptionTime INTEGER
              )''');
        //für Kalender wäre noch ein Datum nötig
      },
      version: 1,
    );
    return database;
  }

  Future<void> addToDataBase(Drug drug) async {
    final db = await initDB();
    await db.insert('medicaments', drug.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }



  get(int id) async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('medicaments',
        columns: null, where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return makeDrug(maps.first);
    }
  }

  Future<void> set(int id, String name, String time, int frequency, int amountLeft, int prescriptionTime) async {
    final db = await initDB();
    await db.update(
      'medicaments',
      {
        'name': name,
        'time': time,
        'frequency': frequency,
        'amountLeft': amountLeft,
        'prescriptionTime': prescriptionTime,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> delete(int id) async {
    final db = await initDB();
    await db.delete(
      'medicaments',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

 search (String name) async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('medicaments',
        columns: null, where: 'name = ?', whereArgs: [name]);
    if (maps.isNotEmpty) {
      return makeDrug(maps.first);
    }
  }

  makeDrug(Map map) {
    Drug drug = Drug(
      id: map['id'],
      name: map['name'],
      time: map['time'],
      frequency: map['frequency'],
      amountLeft: map['amountLeft'],
      prescriptionTime: map['prescriptionTime'],
    );
    return drug;
  }

}


