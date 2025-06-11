#!/bin/sh

if [ "$NODE_ENV" = "development" ]; then
  npm install
  # composer i
fi

# php artisan migrate

exec "$@"
