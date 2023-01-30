import { Router } from "express";
import UsersService from "../services/users.service";
import {
  AuthRequest,
  checkAuthorization,
} from "../middleware/checkAuthorization";

const router = Router();
const usersService = new UsersService();

router.use(checkAuthorization);

router.get("/doctor", async (req, res) => {
  const jwtDoctor = (req as AuthRequest).user;
  const doctor = await usersService.getDoctorById(jwtDoctor.id);
  res.json(doctor.toJson());
});

router.get("/patients", async (req, res) => {
  const jwtDoctor = (req as AuthRequest).user;
  const patients = await usersService.getPatients(jwtDoctor.id);
  res.json({ patients });
});

router.post("/patient", async (req, res) => {
  const jwtDoctor = (req as AuthRequest).user;
  console.log(req.body);
  const name = req.body.name as string | undefined;
  const email = req.body.email as string | undefined;
  if (name) {
    await usersService.createPatient(name, jwtDoctor.id, email);
    res.status(200).json({ msg: "Created" });
  } else {
    res.status(404).json({ error: "Name is required" });
  }
});

router.delete("/patient/:id", async (req, res) => {
  const { id } = req.params;
  try {
    await usersService.deletePatient(id);
    res.status(200).json({ msg: "Deleted" });
  } catch (error) {
    res.json({ error });
  }
});

export default router;
