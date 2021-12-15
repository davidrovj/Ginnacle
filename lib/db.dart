import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'patientsbd.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'patients.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE patients (numexp INTEGER PRIMARY KEY, name TEXT, lastnamep TEXT, lastnamem TEXT, tel TEXT)",
      );
    }, version: 1);
  }

  static Future<void> insert(Patient patient) async {
    Database database = await _openDB();

    return database.insert("patients", patient.toMap());
  }

  static Future<void> delete(Patient patient) async {
    Database database = await _openDB();

    return database
        .delete("patients", where: "numexp = ?", whereArgs: [patient.numExp]);
  }

  static Future<void> update(Patient patient) async {
    Database database = await _openDB();

    return database.update("patients", patient.toMap(),
        where: "id = ?", whereArgs: [patient.numExp]);
  }

  static Future<List<Patient>> patients() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> patientsMap =
        await database.query("patients");

    return List.generate(
        patientsMap.length,
        (i) => Patient(
            numExp: patientsMap[i]['numexp'],
            name: patientsMap[i]['name'],
            lastNameP: patientsMap[i]['lastnamep'],
            lastNameM: patientsMap[i]['lastnamem'],
            tel: patientsMap[i]['tel']));
  }
}
