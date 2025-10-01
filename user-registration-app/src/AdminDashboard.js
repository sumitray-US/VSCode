import React, { useEffect, useState, useCallback } from 'react';
import AdminLogin from './AdminLogin';

/**
 * AdminDashboard displays pending users and allows admin approval/rejection.
 * Uses memoized handlers for performance.
 */
function AdminDashboard() {
  const [token, setToken] = useState(localStorage.getItem('adminToken') || null);
  const [pendingUsers, setPendingUsers] = useState([]);
  const [error, setError] = useState(null);
  const [success, setSuccess] = useState(null);

  useEffect(() => {
    if (!token) return;
    const fetchPendingUsers = async () => {
      try {
        const response = await fetch('http://localhost:4000/users/pending', {
          headers: { Authorization: `Bearer ${token}` }
        });
        if (!response.ok) throw new Error('Failed to fetch pending users');
        setPendingUsers(await response.json());
        setError(null);
      } catch {
        setError('Failed to fetch pending users');
      }
    };
    fetchPendingUsers();
  }, [token, success]);

  // Memoized approve handler
  const approveUser = useCallback(async (id) => {
    try {
      const response = await fetch(`http://localhost:4000/users/approve/${id}`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${token}` }
      });
      if (!response.ok) throw new Error();
      setSuccess('User approved!');
      setError(null);
    } catch {
      setError('Failed to approve user');
    }
  }, [token]);

  // Memoized reject handler
  const rejectUser = useCallback(async (id) => {
    try {
      const response = await fetch(`http://localhost:4000/users/reject/${id}`, {
        method: 'POST',
        headers: { Authorization: `Bearer ${token}` }
      });
      if (!response.ok) throw new Error();
      setSuccess('User rejected!');
      setError(null);
    } catch {
      setError('Failed to reject user');
    }
  }, [token]);

  // Memoized login handler
  const handleLogin = useCallback((jwt) => {
    localStorage.setItem('adminToken', jwt);
    setToken(jwt);
  }, []);

  if (!token) {
    return <AdminLogin onLogin={handleLogin} />;
  }

  return (
    <div className="admin-dashboard">
      <h2>Pending User Approvals</h2>
      {error && <div className="error">{error}</div>}
      {success && <div className="success">{success}</div>}
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody>
          {pendingUsers.map(user => (
            <tr key={user.id}>
              <td>{user.id}</td>
              <td>{user.username}</td>
              <td>{user.email}</td>
              <td>{user.status}</td>
              <td>{user.created_at}</td>
              <td>
                <button onClick={() => approveUser(user.id)}>Approve</button>
                <button onClick={() => rejectUser(user.id)} style={{ marginLeft: 8 }}>Reject</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default AdminDashboard;
