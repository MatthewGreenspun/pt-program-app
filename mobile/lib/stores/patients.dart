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
    final serverExercises = await _patientsService.getPatients();
    patients.addAll(serverExercises);
  }
}
