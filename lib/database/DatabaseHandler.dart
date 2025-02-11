import 'package:mew/Helper/DrugOfDatabase.dart';
import 'package:mew/Helper/NotificationService.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../Helper/Drug.dart';
import '../Helper/DrugState.dart';
import '../Helper/TimeConverter.dart';
import '../states/DrugStates.dart';
import '../states/TakenState.dart';
import '../states/TakeSoonState.dart';
import '../states/SkippedState.dart';
import '../states/TakeTodayState.dart';

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
              state TEXT
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
         drug.toMap()..['state'] = "TakeTodayState",
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
      state: DrugStates.getStateFromString(map['state']),
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
      state: DrugStates.getStateFromString(map['state']),
    );
    return drug;
  }

  Future<void> deleteDatabaseFile(String dbName) async {
    var databasesPath = await getDatabasesPath();
    String path = '$databasesPath/$dbName';
    await deleteDatabase(path);
  }

  Future<void> countOneUpAll() async {
    final db = await initDB();
    List<DrugOfDatabase> drugs = await getAll();

    for (DrugOfDatabase drug in drugs) {
      drug.countUp(); // Jeder Zustand entscheidet selbst, was passiert
      await db.update(
        'medicaments',
        {'counter': drug.counter,
        'state': drug.state.runtimeType.toString()},
        where: 'id = ?',
        whereArgs: [drug.id],
      );
      if (drug.state is TakeTodayState) {
        DateTime dateTime = TimeConverter.parseTimeToDateTime(drug.time);
        await NotificationService.instance.scheduleNotification(
          id: drug.id,
          title: 'Nimm ${drug.name}!',
          body: 'Es ist Zeit ${drug.name} zu nehmen! Du musst ${drug.dosage} nehmen.',
          scheduleTime: dateTime,
        );
      }
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
    print("in updateDrugState id: $id, state: $state");
    final db = await initDB();
    await db.update(
      'medicaments',
      {'state': state.runtimeType.toString()},
      where: 'id = ?',
      whereArgs: [id],
    );
    if (state is TakenState || state is SkippedState) {
      await NotificationService.instance.deleteNotification(id);
    }

  }



}

