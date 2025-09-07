#!/bin/bash
set -e

if [ ! -d "./src" ]; then
    echo "Creating Laravel 12 project..."
    docker compose run --rm composer create-project laravel/laravel:^12.0 .
else
    echo "Laravel project already exists, skipping creation."
fi

echo "Setting permissions for Laravel (macOS-safe)..."
docker compose run --rm app sh -c "chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache"

echo "Building and starting Docker containers..."
docker compose up -d --build

echo "Setup complete! Laravel 12 should be running at http://localhost:8080"
