import 'package:mobile/services/index.dart';
import 'package:mobx/mobx.dart';
import '../models/patient.dart';
import "../services/patients.service.dart";
part 'patients.g.dart';

class PatientsStore = _Patients with _$PatientsStore;

abstract class _Patients with Store {
  final PatientsService _patientsService;
  _Patients(this._patientsService);

  final patients = ObservableList<Patient>();

  @action
  Future<void> fetchPatients() async {
    final serverPatients = await _patientsService.getPatients();
    patients.clear();
    patients.addAll(serverPatients);
  }

  @action
  Future<void> createPatient(String name, String? email) async {
    await _patientsService.createPatient(name, email);
    await fetchPatients();
  }

  @action
  Future<void> deletePatient(String id) async {
    await _patientsService.deletePatient(id);
    await fetchPatients();
  }
}
