import '../Helper/DrugOfDatabase.dart';
import '../Helper/DrugState.dart';
import '../database/DatabaseHandler.dart';
import 'DrugStateBase.dart';

class NotRequiredState extends DrugStateBase {
  /*
  @override
  void handleStateChange(DatabaseHandler dbHandler, int drugId) {
    dbHandler.updateDrugState(drugId, DrugState.NotRequired);
  }

   */
  @override
  void handleStateChange(DatabaseHandler dbHandler, DrugOfDatabase drug) {
    dbHandler.updateDrugState(drug.id, DrugState.notTaken);
    // Counter bleibt unverändert!
  }
}