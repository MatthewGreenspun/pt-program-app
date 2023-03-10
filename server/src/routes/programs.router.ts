import { Router } from "express";
import { checkAuthorization } from "../middleware/checkAuthorization";
import { ProgramExercise } from "../models/Exercise";
import ProgramsService from "../services/programs.service";
import { v4 } from "uuid";

const programsService = new ProgramsService();

const router = Router();
const exerciseRouter = Router();

router.use(checkAuthorization);
router.use("/exercises", exerciseRouter);

router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const program = await programsService.getProgram(id);
    res.json({ program });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error });
  }
});

router.post("/", async (req, res) => {
  console.log(req.body);
  const programId = v4();
  const {
    name,
    patientId,
    exercises,
    description,
  }: {
    name: string;
    patientId: string;
    exercises: ProgramExercise[];
    description: string;
  } = req.body;
  try {
    await programsService.createProgram(
      programId,
      name,
      patientId,
      description
    );
    await programsService.createProgramExercises(programId, exercises);
    await Promise.all(
      exercises.map((exercise) =>
        programsService.updateExercise(exercise, true)
      )
    );

    res.status(200).json({});
  } catch (error) {
    console.error(error);
    res.status(500).json({ error });
  }
  //TODO
});

router.put("/:id", async (req, res) => {
  //TODO
});

router.delete("/:id", async (req, res) => {
  //TODO
});

exerciseRouter.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const exercises = await programsService.getProgramExercises(id);
    res.json({ exercises });
  } catch (error) {
    res.status(500).json({ error });
  }
});

exerciseRouter.post("/:id", async (req, res) => {
  //TODO
});

exerciseRouter.put("/", async (req, res) => {
  console.log(req.body);
  try {
    await programsService.updateExercise(req.body as ProgramExercise);
    res.status(200).json({});
  } catch (error) {
    console.error(error);
    res.status(500).json({ error });
  }
});

exerciseRouter.delete("/:programid/:exerciseid", async (req, res) => {
  //TODO
});

export default router;
