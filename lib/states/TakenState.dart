import '../Helper/DrugOfDatabase.dart';
import '../Helper/DrugState.dart';
import '../database/DatabaseHandler.dart';
import 'DrugStateBase.dart';

class TakenState extends DrugStateBase {
  /*
  @override
  void handleStateChange(DatabaseHandler dbHandler, int drugId) {
    dbHandler.updateDrugState(drugId, DrugState.taken);
  }

   */

  @override
  void handleStateChange(DatabaseHandler dbHandler, DrugOfDatabase drug) async {
  if (drug.counter < drug.frequency - 1) {
  drug.counter += 1;
  } else {
  drug.counter = 0;  // Zurücksetzen, wenn Maximum erreicht
  }
  await dbHandler.updateDrugState(drug.id, DrugState.taken);
  await dbHandler.updateCounter(drug.id, drug.counter);

  }
}