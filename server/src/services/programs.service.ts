import { query } from "../db/db";
import { Program } from "../models/Program";
import { ProgramExercise } from "../models/Exercise";

class ProgramsService {
  async getProgram(id: string) {
    const { rows } = await query(
      `--sql
      SELECT programs.id, patients.name as patient, programs.name, description FROM programs 
      JOIN patients ON patient_id = patients.id 
      WHERE programs.id = $1
      `,
      [id]
    );

    if (rows[0] == null) {
      throw "Program does not exist";
    }
    return Program.fromDb(Object.values(rows[0]));
  }

  async getProgramExercises(id: string) {
    const { rows } = await query(
      `--sql
      SELECT id, name, mediaLink, description, notes, sets, weight, units, reps, time, hours, minutes, seconds FROM (
        SELECT program_id, program_exercises.id as id, exercises.name as name, media_link as mediaLink, description, notes, 
        time, sets, reps, weight, units, hours, minutes, seconds,
        row_number() OVER (partition by program_exercises.exercise_id ORDER BY TIME DESC) AS row_num
        FROM program_exercises 
        JOIN exercises on program_exercises.exercise_id = exercises.id 
        JOIN exercise_modifications ON exercise_modifications.exercise_id = program_exercises.id 
        ) sub
      WHERE program_id = $1 AND row_num=1
      `,
      [id]
    );
    return rows.map((r) => ProgramExercise.fromDb(Object.values(r)));
  }

  async getExerciseProgress(id: string) {
    query(
      `--sql
      SELECT sets, reps, weight, units, hours, minutes, seconds, time 
      FROM exercise_modifications WHERE exercise_id = $1 ORDER BY TIME DESC`,
      [id]
    );
  }
}
export default ProgramsService;

`
SELECT programs.id, programs.name, JSON_AGG(prgm) as exercises FROM (SELECT id, name, mediaLink, description, notes, sets, weight, units, reps, time, hours, minutes, seconds FROM (
  SELECT program_id, program_exercises.id as id, exercises.name as name, media_link as mediaLink, exercises.description, notes, 
  time, sets, reps, weight, units, hours, minutes, seconds,
  row_number() OVER (partition by program_exercises.exercise_id ORDER BY TIME DESC) AS row_num
  FROM program_exercises 
  JOIN exercises on program_exercises.exercise_id = exercises.id 
  JOIN exercise_modifications ON exercise_modifications.exercise_id = program_exercises.id 
  JOIN programs on programs.id = program_exercises.program_id
  ) sub
WHERE row_num = 1) prgm RIGHT JOIN programs ON programs.id != NULL
GROUP BY programs.id, programs.name;
`;
