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

  async createProgram(
    id: string,
    name: string,
    patientId: string,
    description: string
  ) {
    await query(
      `--sql
    INSERT INTO programs (id, name, patient_id, description)
    VALUES ($1, $2, $3, $4)
    `,
      [id, name, patientId, description]
    );
  }

  async createProgramExercises(
    programId: string,
    exercises: ProgramExercise[]
  ) {
    await Promise.all(
      exercises.map((exercise) =>
        query(
          `--sql
    INSERT INTO program_exercises (id, exercise_id, program_id, notes)
    VALUES ($1, $2, $3, $4)
    `,
          [exercise.id, exercise.exerciseId, programId, exercise.notes]
        )
      )
    );
  }

  async getProgramExercises(id: string) {
    const { rows } = await query(
      `--sql
      SELECT id, exerciseId, name, mediaLink, description, notes, sets, weight, units, reps, time, hours, minutes, seconds FROM (
        SELECT program_id, exercise_modifications.exercise_id as exerciseId, program_exercises.id as id, exercises.name as name, 
        media_link as mediaLink, description, notes, time, sets, reps, weight, units, hours, minutes, seconds,
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
    await query(
      `--sql
      SELECT sets, reps, weight, units, hours, minutes, seconds, time 
      FROM exercise_modifications WHERE exercise_id = $1 ORDER BY TIME DESC`,
      [id]
    );
  }

  async updateExercise(exercise: ProgramExercise, newExercise = false) {
    const {
      id,
      exerciseId,
      sets,
      reps,
      weight,
      units,
      hours,
      minutes,
      seconds,
    } = exercise;
    await query(
      `--sql
    INSERT INTO exercise_modifications (exercise_id, sets, reps, weight, units, hours, minutes, seconds)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    `,
      [
        newExercise ? id : exerciseId,
        sets,
        reps,
        weight,
        units,
        hours,
        minutes,
        seconds,
      ]
    );
  }
}
export default ProgramsService;
