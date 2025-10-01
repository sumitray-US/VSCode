import React from 'react';
import ReactDOM from 'react-dom/client';
import './App.css';
import App from './App';
import AdminDashboard from './AdminDashboard';
import StatusLookup from './StatusLookup';
import ErrorBoundary from './components/ErrorBoundary';

const root = ReactDOM.createRoot(document.getElementById('root'));
const path = window.location.pathname;
let component;
if (path === '/admin') {
  component = <AdminDashboard />;
} else if (path === '/status') {
  component = <StatusLookup />;
} else {
  component = <App />;
}
root.render(
  <React.StrictMode>
    <ErrorBoundary>
      {component}
    </ErrorBoundary>
  </React.StrictMode>
);
