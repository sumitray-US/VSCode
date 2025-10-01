const express = require('express');
const router = express.Router();
const { registerHandler, healthHandler, metricsHandler, adminLoginHandler, pendingUsersHandler, approveUserHandler, rejectUserHandler, statusLookupHandler } = require('../workflow/handlers');

router.post('/register', registerHandler);
router.get('/health', healthHandler);
router.get('/metrics', metricsHandler);
router.post('/admin/login', adminLoginHandler);
router.get('/users/pending', pendingUsersHandler);
router.post('/users/approve/:id', approveUserHandler);
router.post('/users/reject/:id', rejectUserHandler);
router.get('/user/status', statusLookupHandler);

module.exports = router;
