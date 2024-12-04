import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mew/database/DatabaseHandler.dart';

import 'package:mew/main.dart';

void main() {
  late DatabaseHandler dbHandler;

  //wird vor jedem Test ausgeführt
  setUp( (){
    dbHandler = DatabaseHandler();
  });
  
  test('Add Drug to Database',()async{
    final drug = Drug(
        id: 1,
        name: 'Paracetamol',
        time : '08:00',
        frequency: 1, //wie oft einnehmen? mehrmals am Tag, ....
        amountLeft: 10,
        prescriptionTime: 7,
        );

    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);

    // Hinzugefügtes Medikament aus der Datenbank abrufen
    final fetchedDrug = await dbHandler.get(drug.id!);

    // Überprüfen, ob das Medikament korrekt gespeichert wurde
    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug?.name, 'Paracetamol');
    expect(fetchedDrug?.time, '08:00');
    expect(fetchedDrug?.frequency, 1);
    expect(fetchedDrug?.amountLeft, 10);
    expect(fetchedDrug?.prescriptionTime, 7);
  });


  test('Set Drug', () async {
    final drug = Drug(
      id: 1,
      name: 'Paracetamol',
      time : '08:00',
      frequency: 1,
      amountLeft: 10,
      prescriptionTime: 7,
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);

    //Medikament aktualisieren
    await dbHandler.set(drug.id!, 'Ibu', '09:00', 1, 10, 7);

    //Aktualisiertes Medikament aus der Datenbank abrufen
    final fetchedDrug = await dbHandler.get(drug.id!);

    //Überprüfen, ob das Medikament korrekt aktualisiert wurde
    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug?.name, 'Ibu');
    expect(fetchedDrug?.time, '09:00');
    expect(fetchedDrug?.frequency, 1);
    expect(fetchedDrug?.amountLeft, 10);
    expect(fetchedDrug?.prescriptionTime, 7);
  });

  test('Get Drug by ID', () async {
    final drug = Drug(
      id: 1,
      name: 'Paracetamol',
      time : '08:00',
      frequency: 1,
      amountLeft: 10,
      prescriptionTime: 7,
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);

    //Medikament aus der Datenbank abrufen
    final fetchedDrug = await dbHandler.get(drug.id!);

    //Überprüfen, ob das Medikament korrekt abgerufen wurde
    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug?.name, 'Paracetamol');
    expect(fetchedDrug?.time, '08:00');
    expect(fetchedDrug?.frequency, 1);
    expect(fetchedDrug?.amountLeft, 10);
    expect(fetchedDrug?.prescriptionTime, 7);

  });

  test('search for Drug by Name', () async {
    final drug = Drug(
      id: 1,
      name: 'Paracetamol',
      time : '08:00',
      frequency: 1,
      amountLeft: 10,
      prescriptionTime: 7,
    );

    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    final fetchedDrug = await dbHandler.search(drug.name);

    expect(fetchedDrug, isNotNull);
    expect(fetchedDrug?.name, 'Paracetamol');
    expect(fetchedDrug?.time, '08:00');
    expect(fetchedDrug?.frequency, 1);
    expect(fetchedDrug?.amountLeft, 10);
    expect(fetchedDrug?.prescriptionTime, 7);
  });
  
  test('Search Drug by Non-Existent Name', () async {
    // Suche nach einem nicht existierenden Medikament
    final fetchedDrug = await dbHandler.search('NonExistentDrug');

    // Sollte null zurückgeben, da das Medikament nicht existiert
    expect(fetchedDrug, isNull);
  });

  test('Delete Drug', () async {
    final drug = Drug(
      id: 1,
      name: 'Paracetamol',
      time: '08:00',
      frequency: 1,
      amountLeft: 10,
      prescriptionTime: 7,
    );
    //Medikament zur Datenbank hinzufügen
    await dbHandler.addToDataBase(drug);
    //Medikament aus der Datenbank löschen
    await dbHandler.delete(drug.id!);
    //Überprüfen, ob das Medikament gelöscht

  });

  test('Delete Non-Existent Drug', () async {
    // Versuch, ein nicht existierendes Medikament zu löschen
    await dbHandler.delete(999);  // ID, die nicht existiert
    // Es sollte keine Fehler werfen und nichts tun
  });
}