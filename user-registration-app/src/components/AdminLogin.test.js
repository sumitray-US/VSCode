import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import AdminLogin from './AdminLogin';

describe('AdminLogin', () => {
  it('renders username and password fields and login button', () => {
    render(<AdminLogin onLogin={jest.fn()} />);
    expect(screen.getByLabelText(/username/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /login/i })).toBeInTheDocument();
  });

  // Add more tests for login logic and error handling as needed
});
