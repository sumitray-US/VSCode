/**
 * Backend API entrypoint.
 * Sets up Express, CORS, JSON parsing, and routes.
 * All business logic is delegated to workflow handlers.
 */
require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();
const allowedOrigins = process.env.CORS_ORIGINS ? process.env.CORS_ORIGINS.split(',') : [];
app.use(cors({
  origin: function(origin, callback) {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error('Not allowed by CORS'));
    }
  },
  credentials: true
}));
app.use(express.json());

// Enforce HTTPS in production
if (process.env.NODE_ENV === 'production') {
  app.use((req, res, next) => {
    if (req.headers['x-forwarded-proto'] !== 'https') {
      return res.redirect('https://' + req.headers.host + req.url);
    }
    next();
  });
}

// Use separated API routes for clarity and maintainability
const apiRoutes = require('./api/routes');
const rateLimiter = require('./rateLimit');
app.use(rateLimiter);
app.use('/', apiRoutes);

const PORT = process.env.PORT || 4000;

const server = app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('SIGTERM received, shutting down server...');
  server.close(() => {
    console.log('Server closed.');
    process.exit(0);
  });
});
process.on('SIGINT', () => {
  console.log('SIGINT received, shutting down server...');
  server.close(() => {
    console.log('Server closed.');
    process.exit(0);
  });
});
