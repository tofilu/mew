//import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

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
              time TEXT, 
              frequency INTEGER,
              amountLeft INTEGER,
              prescriptionTime INTEGER,
              counter INTEGER
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

  getAll() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('medicaments');
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return makeDrug(maps[i]);
      });
    }
    return []; //leere Liste zurückgeben
  }

  Future<void> set(int id, String name, String time, int frequency, int amountLeft, int prescriptionTime, int counter) async {
    final db = await initDB();
    await db.update(
      'medicaments',
      {
        'name': name,
        'time': time,
        'frequency': frequency,
        'amountLeft': amountLeft,
        'prescriptionTime': prescriptionTime,
        'counter': counter,
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
    final List<Map<String, dynamic>> maps = await db.query(
      'medicaments',
      where: 'LOWER(name) LIKE ?',
      whereArgs: ['%${name.toLowerCase()}%'],
    );
    if (maps.isNotEmpty) {
      return makeDrug(maps.first);
    }
  }

  Drug makeDrug(Map map) {
    Drug drug = Drug(
      id: map['id'],
      name: map['name'],
      time: map['time'],
      frequency: map['frequency'],
      amountLeft: map['amountLeft'],
      prescriptionTime: map['prescriptionTime'],
      counter: map['counter'],
    );
    return drug;
  }

  Future<void> deleteDatabaseFile(String dbName) async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/$dbName';
    await deleteDatabase(path);
  }

}


