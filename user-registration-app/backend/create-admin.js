// Usage: node create-admin.js <username> <password>
require('dotenv').config();
const sql = require('mssql');
const bcrypt = require('bcryptjs');

const dbConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_NAME,
  options: {
    encrypt: true,
    trustServerCertificate: true
  }
};

async function createAdmin(username, password) {
  const hash = await bcrypt.hash(password, 10);
  await sql.connect(dbConfig);
  await sql.query`INSERT INTO Admins (username, password) VALUES (${username}, ${hash})`;
  console.log('Admin user created:', username);
  process.exit(0);
}

const [,, username, password] = process.argv;
if (!username || !password) {
  console.error('Usage: node create-admin.js <username> <password>');
  process.exit(1);
}
createAdmin(username, password);
