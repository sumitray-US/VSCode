# Test Strategy

## Coverage Goals
- Aim for >80% code coverage on backend and frontend.
- Use Jest coverage reports to track progress.

## Test File Locations
- Backend: `backend/test/api.test.js`, `backend/test/edgeCases.test.js`, `backend/test/integration.test.js`, `backend/test/worker.test.js`
- Frontend: `src/components/RegistrationForm.test.js`, `src/components/ErrorBoundary.test.js`, `src/components/AdminLogin.test.js`, `src/components/StatusLookup.test.js`

## Running Tests
- Backend: `npm test` in `backend/`
- Frontend: `npm test` in root

## CI Integration
- Integrate tests in CI pipeline (GitHub Actions, Azure Pipelines).
- Example workflow:
	```yaml
	jobs:
		test:
			runs-on: ubuntu-latest
			steps:
				- uses: actions/checkout@v2
				- name: Install dependencies
					run: npm install && cd backend && npm install
				- name: Run backend tests
					run: cd backend && npm test
				- name: Run frontend tests
					run: npm test
	```

## Sample Output
```
PASS backend/test/api.test.js
PASS backend/test/edgeCases.test.js
PASS backend/test/integration.test.js
PASS backend/test/worker.test.js
PASS src/components/RegistrationForm.test.js
PASS src/components/ErrorBoundary.test.js
PASS src/components/AdminLogin.test.js
PASS src/components/StatusLookup.test.js
Test Suites: 8 passed, 8 total
Coverage: 87%
```

## Sample Test Cases
- Registration: Valid/invalid input, duplicate user, weak password
- Admin login: Valid/invalid credentials
- Approval/rejection: Valid/invalid user ID, JWT required
- Status lookup: Existing/non-existing user
- Worker: Queue processing, error handling

## Troubleshooting
- Tests fail: Check for missing dependencies, environment variables, or database connection
- Coverage low: Add more unit and integration tests

## Best Practices
- Write tests for all new features and bug fixes
- Mock external dependencies (RabbitMQ, SQL) in unit tests
- Add edge case and integration tests
