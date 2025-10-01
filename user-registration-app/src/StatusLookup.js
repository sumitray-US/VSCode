import React, { useState, useCallback } from 'react';
import PropTypes from 'prop-types';

/**
 * StatusLookup allows users to check their registration status by email.
 * Uses memoized handlers for performance and PropTypes for type safety.
 */
function StatusLookup({ apiUrl = 'http://localhost:4000/user/status' }) {
  const [email, setEmail] = useState('');
  const [result, setResult] = useState(null);
  const [error, setError] = useState(null);

  // Memoized input change handler
  const handleChange = useCallback((e) => {
    setEmail(e.target.value);
  }, []);

  // Memoized submit handler
  const handleSubmit = useCallback(async (e) => {
    e.preventDefault();
    setError(null);
    setResult(null);
    try {
      const response = await fetch(`${apiUrl}?email=${encodeURIComponent(email)}`);
      if (!response.ok) {
        const err = await response.json();
        throw new Error(err.error || 'Lookup failed');
      }
      setResult(await response.json());
    } catch (err) {
      setError(err.message);
    }
  }, [email, apiUrl]);

  return (
    <div className="status-lookup">
      <h2>Check Registration Status</h2>
      <form onSubmit={handleSubmit}>
        {/* Email input */}
        <label htmlFor="lookup-email">Email:</label>
        <input
          id="lookup-email"
          type="email"
          value={email}
          onChange={handleChange}
          required
          autoComplete="email"
        />
        <button type="submit">Lookup</button>
      </form>
      {/* Error message */}
      {error && <div className="error">{error}</div>}
      {/* Status result */}
      {result && (
        <div className="pending">
          <p>
            Hello <strong>{result.username}</strong>!<br />
            Your registration status: <strong>{result.status}</strong>.<br />
            {result.status === 'PENDING' && 'Your account is awaiting admin approval.'}
            {result.status === 'ACTIVE' && 'Your account is active!'}
            {result.status === 'REJECTED' && 'Your registration was rejected.'}
          </p>
        </div>
      )}
    </div>
  );
}

StatusLookup.propTypes = {
  apiUrl: PropTypes.string,
};

export default StatusLookup;
