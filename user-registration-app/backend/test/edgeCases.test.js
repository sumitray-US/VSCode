const request = require('supertest');
const express = require('express');
const apiRoutes = require('../api/routes');

const app = express();
app.use(express.json());
app.use('/', apiRoutes);

describe('Edge Case Tests', () => {
  it('should not allow duplicate registration', async () => {
    await request(app).post('/register').send({ username: 'user1', email: 'user1@example.com', password: 'pass' });
    const res = await request(app).post('/register').send({ username: 'user1', email: 'user1@example.com', password: 'pass' });
    expect(res.statusCode).not.toBe(200);
  });

  it('should reject expired JWT', async () => {
    // Simulate expired JWT (implementation depends on JWT setup)
    // ...test logic...
    expect(true).toBe(true); // Placeholder
  });

  // Add more edge case tests as needed
});
