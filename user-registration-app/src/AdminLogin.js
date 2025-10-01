import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';

/**
 * AdminLogin handles admin authentication.
 * Uses memoized handlers for performance and PropTypes for type safety.
 */
function AdminLogin({ onLogin }) {
  const [form, setForm] = useState({ username: '', password: '' });
  const [error, setError] = useState(null);

  // Memoized input change handler
  const handleChange = useCallback((e) => {
    const { name, value } = e.target;
    setForm((prev) => ({ ...prev, [name]: value }));
  }, []);

  // Memoized submit handler
  const handleSubmit = useCallback(async (e) => {
    e.preventDefault();
    setError(null);
    try {
      const response = await fetch('http://localhost:4000/admin/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(form)
      });
      if (!response.ok) throw new Error('Login failed');
      const data = await response.json();
      onLogin(data.token);
    } catch {
      setError('Invalid credentials or server error');
    }
  }, [form, onLogin]);

  return (
    <div className="admin-login">
      <h2>Admin Login</h2>
      <form onSubmit={handleSubmit}>
        {/* Username input */}
        <label htmlFor="admin-username">Username:</label>
        <input
          id="admin-username"
          type="text"
          name="username"
          value={form.username}
          onChange={handleChange}
          required
          autoComplete="username"
        />
        {/* Password input */}
        <label htmlFor="admin-password">Password:</label>
        <input
          id="admin-password"
          type="password"
          name="password"
          value={form.password}
          onChange={handleChange}
          required
          autoComplete="current-password"
        />
        <button type="submit">Login</button>
        {/* Error message */}
        {error && <div className="error">{error}</div>}
      </form>
    </div>
  );
}

AdminLogin.propTypes = {
  onLogin: PropTypes.func.isRequired,
};

export default AdminLogin;
