import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import RegistrationForm from './RegistrationForm';

describe('RegistrationForm', () => {
  it('renders all input fields and submit button', () => {
    render(<RegistrationForm onStatus={jest.fn()} />);
    expect(screen.getByLabelText(/username/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/password/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /register/i })).toBeInTheDocument();
  });

  it('calls onStatus on successful submit', async () => {
    const mockRegisterUser = jest.fn().mockResolvedValue({ status: 'PENDING' });
    jest.mock('../api', () => ({ registerUser: mockRegisterUser }));
    const onStatus = jest.fn();
    render(<RegistrationForm onStatus={onStatus} />);
    fireEvent.change(screen.getByLabelText(/username/i), { target: { value: 'testuser', name: 'username' } });
    fireEvent.change(screen.getByLabelText(/email/i), { target: { value: 'test@example.com', name: 'email' } });
    fireEvent.change(screen.getByLabelText(/password/i), { target: { value: 'Password123!', name: 'password' } });
    fireEvent.click(screen.getByRole('button', { name: /register/i }));
    // You can add more assertions here for async behavior
  });
});
