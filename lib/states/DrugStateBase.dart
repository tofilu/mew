import '../Helper/DrugOfDatabase.dart';
import '../Helper/DrugState.dart';
import '../database/DatabaseHandler.dart';

abstract class DrugStateBase {
  void handleStateChange(DatabaseHandler dbHandler, DrugOfDatabase drug);
}
