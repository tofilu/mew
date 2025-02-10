import '../Helper/DrugOfDatabase.dart';
import '../Helper/DrugState.dart';
import '../database/DatabaseHandler.dart';
import 'DrugStateBase.dart';

class NotRequiredState extends DrugStateBase {
  @override
  void handleStateChange(DatabaseHandler dbHandler, DrugOfDatabase drug) {
    dbHandler.updateDrugState(drug.id, drug.state);
    // Counter bleibt unverändert
  }
}