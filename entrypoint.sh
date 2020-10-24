#!/bin/bash
set -e

# Download WordPress
if [ ! -f wp-load.php ]; then
  wp core download --allow-root
fi

# Generate WordPress config
if [ ! -f wp-config.php ]; then
  wp config create \
    --dbname="${DATABASE}" \
    --dbuser="${DB_USER}" \
    --dbpass="${DB_PASSWORD}" \
    --dbhost="${WORDPRESS_DB_HOST}" \
    --skip-check \
    --force \
    --allow-root
fi

# Install WordPress
if ! $(wp core is-installed --allow-root); then
  wp core install \
    --url="${WORDPRESS_URL}" \
    --title="${WORDPRESS_TITLE}" \
    --admin_user="${WORDPRESS_ADMIN_USER}" \
    --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
    --admin_email="${WORDPRESS_ADMIN_MAIL}" \
    --allow-root
fi

exec "$@"
