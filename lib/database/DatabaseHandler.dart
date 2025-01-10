

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Helper/Drug.dart';
import '../Helper/AlarmSetUp.dart';
import '../Helper/TimeConverter.dart';

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
              dosage TEXT,
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
    try {
     int id = await db.insert(
         'medicaments',
         drug.toMap(),
         conflictAlgorithm: ConflictAlgorithm.replace);

     DateTime dateTime = TimeConverter.parseTimeToDateTime(drug.time);
     AlarmSetUp().setAlarm(id, dateTime, drug.frequency);
    } catch (e) {
      print(e);
    }

  }

  Future<Drug> getDrug(int id) async {
      try {
        final db = await initDB();
        final List<Map<String, dynamic>> maps = await db
            .query('medicaments', columns: null, where: 'id = ?', whereArgs: [id]);

        if (maps.isNotEmpty) {
          return makeDrug(maps.first);
        } else {
          throw Exception('Drug not found');
        }
      } catch (e) {
        print('Error: $e');
        // Provide a fallback or show an error message to the user
        return Future.error('Drug not found');
      }
  }



  Future<List<Drug>> getAll() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('medicaments');
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return makeDrug(maps[i]);
      });
    }
    return []; //leere Liste zurückgeben
  }

  Future<void> set(int id, String name, String time, int frequency,
      String dosage, int prescriptionTime, int counter) async {
    final db = await initDB();
    await db.update(
      'medicaments',
      {
        'name': name,
        'time': time,
        'frequency': frequency,
        'dosage': dosage,
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

  Future<Drug> search(String name) async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'medicaments',
      where: 'LOWER(name) LIKE ?',
      whereArgs: ['%${name.toLowerCase()}%'],
    );
    if (maps.isNotEmpty) {
      return makeDrug(maps.first);
    } else {
      throw Exception('Drug not found');
    }
  }

  Drug makeDrug(Map map) {
    Drug drug = Drug(
      id: map['id'],
      name: map['name'],
      time: map['time'],
      frequency: map['frequency'],
      dosage: map['dosage'],
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

  countOneUpAll() async {
    final db = await initDB();
    List<Drug> drugs = await getAll();
    for (Drug drug in drugs) {
        if (drug.counter < drug.frequency - 1) {
          drug.counter = drug.counter + 1;
        }
        else {
          drug.counter = 0;
        }
        await db.update(
          'medicaments',
          {
            'counter': drug.counter,
          },
          where: 'id = ?',
          whereArgs: [drug.id],
        );
    }
  }
}
