# Contributing Guide


Thank you for your interest in contributing!

## Branching Model
- Use `main` for production-ready code.
- Create feature branches from `main` (e.g., `feature/your-feature`).
- Use `fix/` prefix for bugfix branches.

## Pull Request (PR) Process
- Open PRs against `main`.
- PRs require code review and passing tests.
- Include clear description and link to related issues.
- Assign reviewers and request feedback.

## Code Style
- Use ESLint and Prettier for consistent style.
- Write JSDoc comments for exported functions/classes.
- Use descriptive commit messages.
- Follow naming conventions for files and variables.

## Testing
- All new features and fixes require tests.
- Run `npm test` before submitting PRs.
- Add edge case and integration tests for new features.

## Documentation
- Update `/docs` for any user-facing or architectural changes.
- Add examples and troubleshooting for new features.

## Troubleshooting for Contributors
- Failing tests: Check for missing dependencies, environment variables, or database connection.
- Lint errors: Run `npm run lint` and fix style issues.
- Merge conflicts: Rebase your branch on `main` and resolve conflicts.

## Code of Conduct
- Be respectful and collaborative.
- Report issues and suggest improvements.

## Getting Help
- Review `/docs/README.md` and API reference.
- Open issues for bugs or feature requests.
