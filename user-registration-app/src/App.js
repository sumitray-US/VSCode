import React, { useState } from 'react';
import './App.css';
import RegistrationForm from './components/RegistrationForm';

function App() {
  const [status, setStatus] = useState(null);
  const [userInfo, setUserInfo] = useState(null);

  const handleStatus = (res, form) => {
    setStatus(res.status);
    setUserInfo({ username: form.username, email: form.email });
  };

  return (
    <div className="App">
      <h2>User Self-Registration</h2>
      {status ? (
        <div className="pending">
          <p>
            Hello <strong>{userInfo?.username}</strong>!<br />
            Your registration status: <strong>{status}</strong>.<br />
            {status === 'PENDING' && 'Your account is awaiting admin approval.'}
            {status === 'ACTIVE' && 'Your account is active!'}
            {status === 'REJECTED' && 'Your registration was rejected.'}
          </p>
        </div>
      ) : (
        <RegistrationForm onStatus={handleStatus} />
      )}
    </div>
  );
}

export default App;
