import 'package:flutter_test/flutter_test.dart';
import 'package:mew/Helper/Drug.dart';
import 'package:mew/database/DatabaseHandler.dart';
import 'package:mew/Helper/DrugState.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  late DatabaseHandler dbHandler;

  //wird vor jedem Test ausgeführt
  setUp(() {
    print('setUp called');
    dbHandler = DatabaseHandler();
    dbHandler.deleteDatabaseFile('medicament_database.db');
    //muss nur ausgeführt werden da die Datenbank in den Tests nicht geschlossen wird
    print('dbHandler initialized');
  });

  setUpAll(() {
    // Initialisiere sqflite_common_ffi für Tests
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('Add Drug to Database', () async {
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1, //wie oft einnehmen? mehrmals am Tag, ....
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );

    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);

    final drugId = await dbHandler.getDrugId(drug.name);
    // Hinzugefügtes Medikament aus der Datenbank abrufen
    final fetchedDrug = await dbHandler.getDrug(drugId);

    // Überprüfen, ob das Medikament korrekt gespeichert wurde
    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug.name, 'Paracetamol');
    expect(fetchedDrug.time, '08:00');
    expect(fetchedDrug.frequency, 1);
    expect(fetchedDrug.dosage, '1 Tablette');
  });

  test('GetAll drugs', () async{
    print('test');
    final drug1 = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );
    final drug2 = Drug(
      name: 'Ibuprofen',
      time: '09:00',
      frequency: 2,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );

    //Medikamente zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug1);
    await dbHandler.addToDataBase(drug2);

    //Alle Medikamente aus der Datenbank abrufen
    final fetchedDrugs = await dbHandler.getAll();

    //Überprüfen, ob die Medikamente korrekt abgerufen wurden
    expect(fetchedDrugs, isNotNull);
    expect(fetchedDrugs.length, 2);
    expect(fetchedDrugs[0].name, 'Paracetamol');
    expect(fetchedDrugs[1].name, 'Ibuprofen');
  });

  test('get all drugs when database is empty', () async {
    print('test');
    //Alle Medikamente aus der Datenbank abrufen
    final fetchedDrugs = await dbHandler.getAll();

    //Überprüfen, ob die Medikamente korrekt abgerufen wurden
    expect(fetchedDrugs, isNotNull);
    expect(fetchedDrugs.length, 0);
  });

  test('Set Drug', () async {//muss angepasst werden
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    tz.initializeTimeZones();
    final drugId = await dbHandler.getDrugId(drug.name);
    //Medikament aktualisieren
    await dbHandler.set(drugId, 'Ibu', '09:00', 1, '1 Tablette',0);

    //Aktualisiertes Medikament aus der Datenbank abrufen
    final fetchedDrug = await dbHandler.getDrug(drugId);

    //Überprüfen, ob das Medikament korrekt aktualisiert wurde
    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug.name, 'Ibu');
    expect(fetchedDrug.time, '09:00');
    expect(fetchedDrug.frequency, 1);
    expect(fetchedDrug.dosage, '1 Tablette');
  });

  test('Get Drug by ID', () async {
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);

    //Medikament aus der Datenbank abrufen
    final drugId = await dbHandler.getDrugId(drug.name);
    final fetchedDrug = await dbHandler.getDrug(drugId);

    //Überprüfen, ob das Medikament korrekt abgerufen wurde
    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug.name, 'Paracetamol');
    expect(fetchedDrug.time, '08:00');
    expect(fetchedDrug.frequency, 1);
    expect(fetchedDrug.dosage, '1 Tablette');
  });

  test('search for Drug by Name', () async {
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );

    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    final fetchedDrug = await dbHandler.search(drug.name);

    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug.name, 'Paracetamol');
    expect(fetchedDrug.time, '08:00');
    expect(fetchedDrug.frequency, 1);
    expect(fetchedDrug.dosage, '1 Tablette');
  });
  test('search for Drug by Name', () async {
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );

    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    final fetchedDrug = await dbHandler.search('Paracetamol');

    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug.name, 'Paracetamol');
    expect(fetchedDrug.time, '08:00');
    expect(fetchedDrug.frequency, 1);
    expect(fetchedDrug.dosage, '1 Tablette');
  });
  test('search for Drug by Name case insensitive', () async {
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );

    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    final fetchedDrug = await dbHandler.search('paracetamol');

    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug.name, 'Paracetamol');
    expect(fetchedDrug.time, '08:00');
    expect(fetchedDrug.frequency, 1);
    expect(fetchedDrug.dosage, '1 Tablette');
  });

  test('search for Drug by partial Name ', () async {
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );

    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    final fetchedDrug = await dbHandler.search('paraceta');

    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug.name, 'Paracetamol');
    expect(fetchedDrug.time, '08:00');
    expect(fetchedDrug.frequency, 1);
    expect(fetchedDrug.dosage, '1 Tablette');
  });


  test('Search Drug by Non-Existent Name', () async {
    print('test');
    // Suche nach einem Medikament, das nicht existiert
    expect(
          () async => await dbHandler.search('NonExistentDrug'),
      throwsException,
    );

  });

  test('Delete Drug', () async {
    print('test');
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state : DrugState.notTaken,
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    //Medikament aus der Datenbank löschen
    final drugId = await dbHandler.getDrugId(drug.name);
    await dbHandler.delete(drugId);
    //Überprüfen, ob das Medikament gelöscht
  });

  test('Delete Non-Existent Drug', () async {
    print('test');
    // Versuch, ein nicht existierendes Medikament zu löschen
    await dbHandler.delete(999); // ID, die nicht existiert
    // Es sollte keine Fehler werfen und nichts tun
  });
}
