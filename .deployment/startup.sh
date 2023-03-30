#!/bin/sh

ARTISAN_FILE="/app/artisan"

# Check if artisan exists and is executable
if [[ -x "$(command -v php)" && -x "${ARTISAN_FILE}" ]]; then
    # Check if SKIP_OPTIMIZE_COMMANDS is NOT set
    if [[ -z "${SKIP_OPTIMIZE_COMMANDS}" ]]; then
        echo "Running artisan commands for production environment..."

        # Run recommended artisan commands for production
        php ${ARTISAN_FILE} config:cache
        php ${ARTISAN_FILE} route:cache
        php ${ARTISAN_FILE} view:cache
        php ${ARTISAN_FILE} optimize
    else
        echo "Skipping optimization commands due to the SKIP_OPTIMIZE_COMMANDS environment variable."
    fi
else
    echo "Artisan or PHP not found. Skipping optimization commands."
fi


echo "Starting PHP FPM in daemon mode"
php-fpm -D

echo "Testing NGINX"
nginx -t
cat /etc/nginx/nginx.conf

echo "Starting NGINX"
nginx
