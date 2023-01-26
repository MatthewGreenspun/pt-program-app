import { Pool, QueryResultRow } from "pg";
require("dotenv").config();

const pool = new Pool({
  connectionString: process.env.DB_URI,
});

export function query<T extends QueryResultRow>(
  text: string,
  params?: Array<any>
) {
  return pool.query<T, any[]>(text, params);
}
