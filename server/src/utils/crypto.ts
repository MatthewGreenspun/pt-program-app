import bcrypt from "bcrypt";

const SALT_ROUNDS = 10;

export async function genHash(password: string): Promise<string> {
  const salt = await bcrypt.genSalt(SALT_ROUNDS);
  const hash = await bcrypt.hash(password, salt);
  return hash;
}

export async function verifyPassword(password: string, hash: string): Promise<boolean> {
  const isMatch = await bcrypt.compare(password, hash);
  return isMatch;
}

export async function test() {
  const hash = await genHash("test123");
  console.log("hash: ", hash, hash.length);
  const isMatch = await verifyPassword("mxsupersecurepassword123", hash);
  console.log(isMatch);
}
