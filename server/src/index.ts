import express from "express";
import usersRouter from "./routes/users.router";
require("dotenv").config();
const app = express();

app.use("/users", usersRouter);

app.get("/", (req, res) => {
  res.json({ ip: req.ip, headers: req.headers });
});

app.listen(process.env.PORT || 8080, () => console.log("server listening"));
