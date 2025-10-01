import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import StatusLookup from './StatusLookup';

describe('StatusLookup', () => {
  it('renders email input and lookup button', () => {
    render(<StatusLookup />);
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /lookup/i })).toBeInTheDocument();
  });

  // Add more tests for API integration and error handling as needed
});
