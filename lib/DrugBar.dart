import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper/Drug.dart';

abstract class DrugBar extends StatelessWidget {
  late Drug drug;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(drug.hashCode.toString()), // Eindeutiger Schlüssel für Dismissible
      direction: DismissDirection.horizontal, // Links oder rechts wischen
      background: Container(
        color: Colors.red, // Hintergrundfarbe beim Wischen
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Icon(Icons.delete, color: Colors.white, size: 30), // Icon links
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white, size: 30), // Icon rechts
      ),
      onDismissed: (direction) {
        // Hier kannst du die Löschlogik implementieren
        print("${drug} wurde gelöscht");
      },
      child: Card(
        elevation: 5.0,
        color: Colors.grey,
        shape: RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.circular(15.0)
        ),
        clipBehavior: Clip.antiAlias,
        child: ListBody(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
              child: buildBar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBar(BuildContext context);
}
