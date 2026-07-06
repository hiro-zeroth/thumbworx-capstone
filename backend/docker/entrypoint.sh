#!/bin/sh
set -e

php artisan key:generate --force || true
php artisan migrate --force || true

# Generate wayfinder types only when app is running
if [ "$APP_ENV" != "production" ]; then
  php artisan wayfinder:generate --with-form || true
fi

exec "$@"
