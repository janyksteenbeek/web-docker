#!/bin/sh

ARTISAN_FILE="/app/artisan"

# Check if PHP-CLI is installed and if artisan exists
if [[ -x "$(command -v php)" && -f "${ARTISAN_FILE}" ]]; then
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
    if [[ -z "${SKIP_STORAGE_LINK}" ]]; then
        echo "Symlinking public storage..."

        # Run recommended artisan commands for production
        php ${ARTISAN_FILE} storage:link --force
    else
        echo "Skipping public storage linking due to the SKIP_STORAGE_LINK environment variable."
    fi
else
    echo "Artisan or PHP not found. Skipping production initialization commands."
fi


echo "Starting PHP FPM in daemon mode"
php-fpm -D

echo "Testing NGINX"
nginx -t
cat /etc/nginx/nginx.conf

echo "Starting NGINX"
nginx
