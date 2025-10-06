#!/bin/bash

echo "Starting services..."

# Start supervisord in background
sudo /usr/bin/supervisord -sc /etc/supervisor/conf.d/supervisord.conf &

# Wait for MySQL to start
echo "Waiting for MySQL to be ready..."
for i in {1..30}; do
    if sudo mysqladmin -u root ping &>/dev/null; then
        break
    fi
    sleep 1
done

# Running MySQL startup script
echo "Setting up database..."
sudo mysql -u root < /setup.sql

# Execute whatever command was passed (default: /bin/bash)
echo "Setup done! Dropping you to shell-window or command ($@)"
exec "$@"