import 'package:mew/Helper/DrugOfDatabase.dart';
import 'package:mew/Helper/NotificationService.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Helper/Drug.dart';
import '../Helper/DrugState.dart';
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
              counter INTEGER,
              state DrugState
              )''');
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
         drug.toMap()..['state'] = DrugState.notTaken.index,
         conflictAlgorithm: ConflictAlgorithm.replace);
     print('Inserted drug with ID: $id');

     DateTime dateTime = TimeConverter.parseTimeToDateTime(drug.time);
     await NotificationService.instance.scheduleNotification(
       id: id,
       title: 'Nimm ${drug.name}!',
       body: 'Es ist Zeit ${drug.name} zu nehmen! Du musst ${drug.dosage} nehmen.',
       scheduleTime: dateTime,
     );
    } catch (e) {
      print(e);
    }
    _printAll();
  }

  _printAll() async {
    List<Drug> drugs = await getAll();
    for (Drug drug in drugs) {
      print(drug.toString());
    }
  }

  Future<DrugOfDatabase> getDrug(int id) async {
      try {
        final db = await initDB();
        final List<Map<String, dynamic>> maps = await db
            .query('medicaments', columns: null, where: 'id = ?', whereArgs: [id]);

        if (maps.isNotEmpty) {
          return _makeDrugOfDatabase(maps.first);
        } else {
          throw Exception('Drug not found');
        }
      } catch (e) {
        print('Error: $e');
        // Provide a fallback or show an error message to the user
        return Future.error('Drug not found');
      }
  }

  Future<List<DrugOfDatabase>> getAll() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('medicaments');
    if (maps.isNotEmpty) {
      return List.generate(maps.length, (i) {
        return _makeDrugOfDatabase(maps[i]);
      });
    }
    return [];
  }

  Future<void> set(int id, String name, String time, int frequency,
      String dosage, int counter) async {
    final db = await initDB();
    await db.update(
      'medicaments',
      {
        'name': name,
        'time': time,
        'frequency': frequency,
        'dosage': dosage,
        'counter': counter,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    await NotificationService.instance.deleteNotification(id);// Noti löschen

    DateTime dateTime = TimeConverter.parseTimeToDateTime(time);
    await NotificationService.instance.scheduleNotification(
      id: id,
      title: 'Nimm $name!',
      body: 'Es ist Zeit $name zu nehmen! Du musst $dosage nehmen.',
      scheduleTime: dateTime,
    );

  }

  Future<void> delete(int id) async {
    final db = await initDB();
    await db.delete(
      'medicaments',
      where: 'id = ?',
      whereArgs: [id],
    );
    NotificationService.instance.deleteNotification(id);
  }

  Future<Drug> search(String name) async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'medicaments',
      where: 'LOWER(name) LIKE ?',
      whereArgs: ['%${name.toLowerCase()}%'],
    );
    if (maps.isNotEmpty) {
      return _makeDrug(maps.first);
    } else {
      throw Exception('Drug not found');
    }
  }

  Drug _makeDrug(Map map) {
    Drug drug = Drug(
      name: map['name'],
      time: map['time'],
      frequency: map['frequency'],
      dosage: map['dosage'],
      counter: map['counter'],
      state: DrugState.values[map['state']],
    );
    return drug;
  }

  DrugOfDatabase _makeDrugOfDatabase(Map map) {
    DrugOfDatabase drug = DrugOfDatabase(
      id: map['id'],
      name: map['name'],
      time: map['time'],
      frequency: map['frequency'],
      dosage: map['dosage'],
      counter: map['counter'],
      state: DrugState.values[map['state']],
    );
    return drug;
  }

  Future<void> deleteDatabaseFile(String dbName) async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/$dbName';
    await deleteDatabase(path);
  }
/*
  Future<void> countOneUpAll() async {
    final db = await initDB();
    List<DrugOfDatabase> drugs = await getAll();
    if (drugs.isNotEmpty) {
      for (DrugOfDatabase drug in drugs) {
        if (drug.counter < drug.frequency - 1) {
          drug.counter = drug.counter + 1;
        }
        else {
          drug.counter = 0;
          updateDrugState(drug.id, DrugState.notTaken);
        }
        await db.update(
          'medicaments',
          {
            'counter': drug.counter,
          },
          where: 'id = ?',
          whereArgs: [drug.id],
        );
        print( "drug.counter ${drug.counter}");
      }
    }
  }

 */
  Future<void> countOneUpAll() async {
    final db = await initDB();
    List<DrugOfDatabase> drugs = await getAll();

    for (DrugOfDatabase drug in drugs) {
      drug.countUp(); // Jeder Zustand entscheidet selbst, was passiert
      await db.update(
        'medicaments',
        {'counter': drug.counter},
        where: 'id = ?',
        whereArgs: [drug.id],
      );
      print("Aktueller Counter für ${drug.name}: ${drug.counter}, Zustand: ${drug._state.runtimeType}");
    }
  }

  Future<int> getDrugId(String name) async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'medicaments',
      where: 'name = ?',
      whereArgs: [name],
    );
    if (maps.isNotEmpty) {
      return maps.first['id'];
    } else {
      throw Exception('Drug not found');
    }
  }

  Future<void> updateDrugState(int id, DrugStates state) async {
    final db = await initDB();
    await db.update(
      'medicaments',
      {'state': state.index},  // Speichert als Integer
      where: 'id = ?',
      whereArgs: [id],
    );
    if (state == TankenState || state == SkippenState) {
      await NotificationService.instance.deleteNotification(id);
    }
    /*
    if (state == DrugState.notTaken){
      DrugOfDatabase drug = await getDrug(id);
      DateTime dateTime = TimeConverter.parseTimeToDateTime(drug.time);
      await NotificationService.instance.scheduleNotification(
        id: id,
        title: 'Nimm ${drug.name}!',
        body: 'Es ist Zeit ${drug.name} zu nehmen! Du musst ${drug.dosage} nehmen.',
        scheduleTime: dateTime,
      );
    }

     */
  }

}

