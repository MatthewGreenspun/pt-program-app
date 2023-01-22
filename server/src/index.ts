import express from "express";
import usersRouter from "./routes/users.router";
import authRouter from "./routes/auth.router";
require("dotenv").config();
const app = express();

app.use(express.json());
app.use("/users", usersRouter);
app.use("/auth", authRouter);

app.get("/", (req, res) => {
  res.json({ msg: "test", ip: req.ip, headers: req.headers });
});

app.listen(process.env.PORT || 8080, () =>
  console.log("server listening on port 8080")
);
