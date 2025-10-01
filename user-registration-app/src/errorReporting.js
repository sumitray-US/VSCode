// Frontend error reporting stub (Sentry or similar)
// To enable, install @sentry/react and configure DSN
// import * as Sentry from '@sentry/react';
// Sentry.init({ dsn: 'YOUR_SENTRY_DSN' });

export function reportError(error) {
  // Sentry.captureException(error);
  // For now, just log to console
  console.error('Frontend error:', error);
}
