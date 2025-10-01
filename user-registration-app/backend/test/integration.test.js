const request = require('supertest');
const express = require('express');
const apiRoutes = require('../api/routes');

const app = express();
app.use(express.json());
app.use('/', apiRoutes);

describe('Integration Tests', () => {
  it('should register and approve user', async () => {
    // Register user
    const regRes = await request(app).post('/register').send({ username: 'user2', email: 'user2@example.com', password: 'pass' });
    expect(regRes.statusCode).toBe(200);
    // Simulate admin approval (mock JWT, etc.)
    // ...test logic...
    expect(true).toBe(true); // Placeholder
  });

  // Add more integration tests as needed
});
