import { query } from "../db/db";
import { Exercise } from "../models/Exercise";

class ExercisesService {
  async getExercises() {
    const { rows } = await query<string[]>(
      "SELECT id, name, media_link AS mediaLink, description FROM exercises"
    );
    const exercises = rows.map((row) => Exercise.fromDb(Object.values(row)));
    return exercises;
  }
}
export default ExercisesService;
