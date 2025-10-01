# Frontend Guide

## Component Hierarchy
- `App.js`: Main entry, renders registration or dashboard.
- `components/RegistrationForm.js`: Handles user registration.
- `components/ErrorBoundary.js`: Catches UI errors.
- `AdminDashboard.js`: Admin approval workflow.
- `AdminLogin.js`: Admin authentication.
- `StatusLookup.js`: User status check.

## UI Walkthrough
- Registration: Enter username, email, password; submit form.
- Status Lookup: Enter username; view current registration status.
- Admin Login: Enter admin credentials; access dashboard.
- Admin Dashboard: View pending users; approve/reject with one click.

## Props & State Usage
- All forms use controlled components and React state.
- Memoized handlers for performance.
- PropTypes used for type safety.

## Error Boundaries
- `ErrorBoundary.js` wraps main app for robust error handling.
- Errors are displayed with user-friendly messages.

## Accessibility Checklist
- All forms use labels and ARIA attributes.
- Error messages use `role="alert"` for screen readers.
- Tab order and keyboard navigation supported.

## API Integration
- API calls abstracted in `src/api.js`.
- All network errors handled gracefully.

## Testing
- Use React Testing Library and Jest.
- Example tests in `components/*.test.js`.
- Coverage reports generated with Jest.

## Security
- No sensitive data stored in frontend.
- JWT stored in memory/localStorage for admin only.

## Troubleshooting
- UI not updating: Check React state and props.
- API errors: Check network tab and backend logs.
- Accessibility issues: Use screen reader and keyboard navigation to test.
