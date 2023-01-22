import { Request, Response, NextFunction } from "express";
import jwt, { Secret } from "jsonwebtoken";

export interface AuthRequest extends Request {
  user: any;
}

export function checkAuthorization(
  req: Request,
  res: Response,
  next: NextFunction
) {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) {
    res.status(403).json({ error: "Unauthorized" });
  } else {
    jwt.verify(
      token,
      process.env.ACCESS_TOKEN_SECRET as Secret,
      (error, user) => {
        if (error) {
          res.status(403).json({ error: "Unauthorized" });
        }
        if (user) {
          (req as AuthRequest).user = user;
          next();
        }
      }
    );
  }
}
