import { Router } from "express";
import { checkAuthorization } from "../middleware/checkAuthorization";
import ProgramsService from "../services/programs.service";

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

exerciseRouter.put("/:programid/:exerciseid", async (req, res) => {
  //TODO
});

exerciseRouter.delete("/:programid/:exerciseid", async (req, res) => {
  //TODO
});

export default router;
