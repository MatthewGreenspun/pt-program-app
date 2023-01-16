import { query } from "../db/db";
import { Doctor } from "../models/Doctor";

class UsersService {
  async getDoctorById(id: string) {
    const { rows } = await query(
      "SELECT id, name, email, join_code FROM doctors WHERE id = $1",
      [id]
    );
    const values = Object.values(rows[0]);
    return Doctor.fromDb(values);
  }
}
export default UsersService;
