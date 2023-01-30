import '../models/patient.dart';
import './base.service.dart';

class PatientsService extends BaseService {
  PatientsService() : super();

  Future<List<Patient>> getPatients() async {
    final res = await request("/users/patients", Method.get);
    if (res['patients'] != null) {
      final patients = (res['patients'] as List<dynamic>)
          .map((patient) => Patient(
              patient['id'],
              patient['doctorId'],
              patient['name'],
              patient['email'],
              _stringifyList(patient['programIds']),
              _stringifyList(patient['programNames'])))
          .toList();
      return patients;
    } else {
      throw "Failed to fetch patients";
    }
  }

  Future<void> createPatient(String name, String? email) async {
    final res = await request("/users/patient", Method.post,
        data: {"name": name, "email": email});
    if (res['error'] != null) {
      throw res['error'];
    }
  }

  Future<void> deletePatient(String id) async {
    final res = await request(
      "/users/patient/$id",
      Method.delete,
    );
    if (res['error'] != null) {
      throw res['error'];
    }
  }

  List<String> _stringifyList(List<dynamic> list) {
    return list.map((e) => e.toString()).toList();
  }
}
