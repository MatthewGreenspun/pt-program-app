"select patients.id, patients.doctor_id, patients.name, patients.email, array_agg(programs.id) as programIds, array_agg(programs.name) as programNames from patients join programs on programs.patient_id = patients.id group by patients.id";
