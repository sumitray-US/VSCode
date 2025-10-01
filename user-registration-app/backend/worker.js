/**
 * RabbitMQ worker to process user registrations.
 * Decouples registration workflow for horizontal scaling.
 */
require('dotenv').config();
const amqp = require('amqplib');
const sql = require('mssql');

const RABBITMQ_URL = process.env.RABBITMQ_URL || 'amqp://rabbitmq';
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

// Main worker loop
async function startWorker() {
  const conn = await amqp.connect(RABBITMQ_URL);
  const ch = await conn.createChannel();
  const queue = 'user_registrations';
  await ch.assertQueue(queue, { durable: true });

  /**
   * Processes a single registration message from the queue.
   * Checks for duplicate email before inserting.
   */
  const processMessage = async (msg) => {
    if (!msg) return;
    const { username, email, password } = JSON.parse(msg.content.toString());
    try {
      await sql.connect(dbConfig);
      const existing = await sql.query`SELECT id FROM Users WHERE email = ${email}`;
      if (existing.recordset.length === 0) {
        await sql.query`
          INSERT INTO Users (username, email, password, status)
          VALUES (${username}, ${email}, ${password}, 'PENDING');
        `;
        console.log('User registered:', email);
      } else {
        console.log('Duplicate email, skipped:', email);
      }
    } catch (err) {
      console.error('DB error:', err.message);
    }
    ch.ack(msg);
  };

  ch.consume(queue, processMessage, { noAck: false });
  console.log('Worker started, waiting for messages...');
}

startWorker().catch(console.error);
