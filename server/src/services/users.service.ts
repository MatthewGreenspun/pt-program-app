import { query } from "../db/db";
import { Doctor } from "../models/Doctor";
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
}
export default UsersService;
