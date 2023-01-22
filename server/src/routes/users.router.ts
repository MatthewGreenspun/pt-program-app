import { Router } from "express";
import UsersService from "../services/users.service";
import {
  AuthRequest,
  checkAuthorization,
} from "../middleware/checkAuthorization";

const router = Router();
const usersService = new UsersService();

router.get("/doctor", checkAuthorization, async (req, res) => {
  const jwtDoctor = (req as AuthRequest).user;
  const doctor = await usersService.getDoctorById(jwtDoctor.id);
  res.json(doctor.toJson());
});

export default router;
