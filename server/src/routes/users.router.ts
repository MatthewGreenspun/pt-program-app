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

export default router;
