import { query } from "../db/db";
import { Doctor } from "../models/Doctor";
import { Patient } from "../models/Patient";
import { verifyPassword } from "../utils/crypto";
import jwt, { Secret } from "jsonwebtoken";

class UsersService {
  async getDoctorById(id: string) {
    const { rows } = await query(
      "SELECT id, name, email, join_code FROM doctors WHERE id = $1",
      [id]
    );
    if (rows[0] == null) {
      throw "User does not exist";
    }
    const values = Object.values(rows[0]); //TODO check for null value
    return Doctor.fromDb(values);
  }

  async verifyDoctor(email: string, password: string) {
    const { rows } = await query(
      "SELECT id, name, email, join_code, pw_hash FROM doctors WHERE email = $1",
      [email]
    );
    if (rows[0] == null) {
      throw "Doctor does not exist";
    }
    const isVerified = await verifyPassword(password, rows[0].pw_hash);
    if (isVerified) {
      const values = Object.values(rows[0]).slice(0, 4);
      const doctor = Doctor.fromDb(values);
      const token = jwt.sign(
        doctor.toJson(),
        process.env.ACCESS_TOKEN_SECRET as Secret
      );
      return token;
    } else {
      throw "invalid email or password";
    }
  }

  async getPatients(doctorId: string) {
    const { rows } = await query<string[]>(
      `
      SELECT patients.id, patients.doctor_id, patients.name, 
      patients.email, ARRAY_AGG(programs.id) AS "programIds", ARRAY_AGG(programs.name) AS "programNames" 
      FROM patients 
      LEFT JOIN programs ON programs.patient_id = patients.id 
      WHERE patients.doctor_id = $1
      GROUP BY patients.id
      `,
      [doctorId]
    );

    const patients = rows.map((row) => Patient.fromDb(Object.values(row)));
    return patients;
  }

  async createPatient(name: string, doctorId: string, email?: string) {
    await query(
      "INSERT INTO patients (name, doctor_id, email) values ($1, $2, $3)",
      [name, doctorId, email ?? ""]
    );
  }

  async deletePatient(id: string) {
    await query("DELETE FROM patients WHERE id = $1", [id]);
  }
}
export default UsersService;
