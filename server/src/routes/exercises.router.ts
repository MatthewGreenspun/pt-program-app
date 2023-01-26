import { Router } from "express";
import { checkAuthorization } from "../middleware/checkAuthorization";
import ExercisesService from "../services/exercises.service";

const router = Router();
const exercisesService = new ExercisesService();

router.get("/", checkAuthorization, async (_, res) => {
  const exercises = await exercisesService.getExercises();
  res.json({ exercises });
});

export default router;
