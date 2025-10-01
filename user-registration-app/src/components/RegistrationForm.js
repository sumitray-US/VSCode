import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';
import { registerUser } from '../api';

/**
 * RegistrationForm handles user input and registration submission.
 * Uses memoized handlers for performance and PropTypes for type safety.
 */
function RegistrationForm({ onStatus }) {
  const [form, setForm] = useState({ username: '', email: '', password: '' });
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
      const response = await registerUser(form);
      onStatus(response, form);
    } catch (err) {
      setError(err.message || 'Registration failed.');
    }
  }, [form, onStatus]);

  return (
    <form onSubmit={handleSubmit} className="registration-form">
      {/* Username input */}
      <label htmlFor="username">Username:</label>
      <input
        id="username"
        type="text"
        name="username"
        value={form.username}
        onChange={handleChange}
        required
        autoComplete="username"
        aria-label="Username"
      />

      {/* Email input */}
      <label htmlFor="email">Email:</label>
      <input
        id="email"
        type="email"
        name="email"
        value={form.email}
        onChange={handleChange}
        required
        autoComplete="email"
        aria-label="Email"
      />

      {/* Password input */}
      <label htmlFor="password">Password:</label>
      <input
        id="password"
        type="password"
        name="password"
        value={form.password}
        onChange={handleChange}
        required
        autoComplete="new-password"
        aria-label="Password"
      />

      <button type="submit">Register</button>
      {/* Error message */}
      {error && <div className="error" role="alert">{error}</div>}
    </form>
  );
}

RegistrationForm.propTypes = {
  onStatus: PropTypes.func.isRequired,
};

export default RegistrationForm;
