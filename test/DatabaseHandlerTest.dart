import 'package:flutter_test/flutter_test.dart';
import 'package:mew/Helper/Drug.dart';
import 'package:mew/database/DatabaseHandler.dart';
import 'package:mew/states/TakeTodayState.dart';
import 'package:mew/states/TakenState.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  late DatabaseHandler dbHandler;

  //wird vor jedem Test ausgeführt
  setUp(() {
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
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
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

  test('GetAll drugs', () async {
    final drug1 = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
    );
    final drug2 = Drug(
      name: 'Ibuprofen',
      time: '09:00',
      frequency: 2,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
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
    //Alle Medikamente aus der Datenbank abrufen
    final fetchedDrugs = await dbHandler.getAll();

    //Überprüfen, ob die Medikamente korrekt abgerufen wurden
    expect(fetchedDrugs, isNotNull);
    expect(fetchedDrugs.length, 0);
  });

  test('Set Drug', () async { //muss angepasst werden
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    tz.initializeTimeZones();
    final drugId = await dbHandler.getDrugId(drug.name);
    //Medikament aktualisieren
    await dbHandler.set(drugId, 'Ibu', '09:00', 1, '1 Tablette', 0);

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
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
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
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
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
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
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
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
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
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
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
    expect(
          () async => await dbHandler.search('NonExistentDrug'),
      throwsException,
    );
  });

  test('Delete Drug', () async {
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    //Medikament aus der Datenbank löschen
    final drugId = await dbHandler.getDrugId(drug.name);
    await dbHandler.delete(drugId);
    //Überprüfen, ob das Medikament gelöscht
  });

  test('Delete Non-Existent Drug', () async {
    await dbHandler.delete(999); // ID, die nicht existiert
  });

  test(' delete Databse File', () async {
    final drug1 = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 2,
      dosage: '1 Tablette',
      counter: 1,
      state: TakenState(),
    );
    await dbHandler.deleteDatabaseFile('medicament_database.db');
    await dbHandler.getAll();
    expect(await dbHandler.getAll(), isEmpty);
  });

  test(' Count Drugs', () async {
    final drug1 = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 2,
      dosage: '1 Tablette',
      counter: 1,
      state: TakenState(),
    );


    //Medikamente zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug1);

    //Anzahl der Medikamente in der Datenbank zählen
    await dbHandler.countOneUpAll();
    final count = drug1.counter;

    //Überprüfen, ob die Anzahl korrekt ist
    expect(count, 1);

  });


  test('getDrugId()', () async {
    // Arrange
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
    );
    await dbHandler.addToDataBase(drug);

    // Act
    final drugId = await dbHandler.getDrugId(drug.name);

    // Assert
    expect(drugId, isNotNull);
  });

  test('Test updateDrugState()', () async {
    // Arrange
    final drug = Drug(
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      dosage: '1 Tablette',
      counter: 0,
      state: TakeTodayState(),
    );
    await dbHandler.addToDataBase(drug);
    final drugId = await dbHandler.getDrugId(drug.name);
    dbHandler.updateDrugState(drugId, TakenState());
    final fetchedDrug = await dbHandler.getDrug(drugId);

    // Assert
    expect(fetchedDrug.state, isInstanceOf<TakenState>());
  });

}