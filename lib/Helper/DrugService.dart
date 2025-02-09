import 'package:mew/Helper/DrugState.dart';
import 'package:mew/database/DatabaseHandler.dart';
import 'DrugOfDatabase.dart';
import 'Drug.dart';

class DrugService {
  static final DrugService _instance = DrugService._internal();
  factory DrugService() {
    return _instance;
  }

  DrugService._internal();

  final DatabaseHandler _dbHandler = DatabaseHandler();

  Future<void> addDrug(Drug drug) async {
    await _dbHandler.addToDataBase(drug);
  }

  Future<List<DrugOfDatabase>> getAllDrugs() async {
    return await _dbHandler.getAll();
  }

  Future<void> delete(int id) async {
    await _dbHandler.delete(id);
  }

  Future<int> getDrugId(String name) async {
    return await _dbHandler.getDrugId(name);
  }

  Future<void> update(int id, String name, String time, int frequency, String dosage, int counter) async {
    await _dbHandler.set(id, name, time, frequency, dosage, counter);
  }

  Future<void> updateState(int id, DrugState state) async {
    await _dbHandler.updateDrugState(id, state);
  }


}