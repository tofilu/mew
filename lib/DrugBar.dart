import 'package:flutter/material.dart';
import 'Helper/Drug.dart';
import 'database/DatabaseHandler.dart';

abstract class DrugBar extends StatelessWidget {
  late Drug drug;
  late DatabaseHandler databaseHandler;

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListBody(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
          child: buildBar(context),
        ),
      ]),
    );

    // Falls die Karte als dismissible sein soll, umschließen wir sie mit `Dismissible`
    if (isDismissibleCard()) {
      return Dismissible(
        key: Key(drug.name), // Eindeutiger Key für Dismissible
        direction: DismissDirection.endToStart, // Wischen von rechts nach links erlaubt
        background: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: Colors.red[300], // Hintergrundfarbe beim Wischen
          child: Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (direction) async {
          databaseHandler = DatabaseHandler();
          int drugId = await databaseHandler.getDrugId(drug.name);
          databaseHandler.delete(drugId);
        },
        child: card,
      );
    } else {
      return card;
    }
  }

  /// Diese Methode kann von Unterklassen überschrieben werden
  bool isDismissibleCard() {
    return false;
  }

  Widget buildBar(BuildContext context);
}