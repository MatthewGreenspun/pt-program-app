import { Router } from "express";
import UsersService from "../services/users.service";

const router = Router();
const usersService = new UsersService();

router.get("/doctor/:id", async (req, res) => {
  const { id } = req.params;
  const doctor = await usersService.getDoctorById(id);
  res.json(doctor.toJson());
});

export default router;
