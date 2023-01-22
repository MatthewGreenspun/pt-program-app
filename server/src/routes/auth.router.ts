import { Router } from "express";
import UsersService from "../services/users.service";

const router = Router();
const usersService = new UsersService();

router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  console.log(email, password);
  try {
    const token = await usersService.verifyDoctor(email, password);
    console.log("token: ", token);
    res.json({ token });
  } catch (err) {
    console.error("login error: ", err);
    res.status(403).json({ error: "Unauthorized" });
    // create a new user
    //TODO separate login / signup
  }
});

export default router;
