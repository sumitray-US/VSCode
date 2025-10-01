const request = require('supertest');
const express = require('express');
const apiRoutes = require('../api/routes');

describe('API Routes', () => {
  const app = express();
  app.use(express.json());
  app.use('/', apiRoutes);

  it('should respond to health check', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe('ok');
  });

  // Add more tests for registration, login, etc.
});
