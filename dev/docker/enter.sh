#!/usr/bin/env bash

# Auto-detect your user ID
USER_ID=$(id -u)
GROUP_ID=$(id -g)
USERNAME=$(whoami)

# Export variables
export USER_ID
export GROUP_ID
export USERNAME

# Build & start the stack
docker-compose up -d --remove-orphans app && docker compose attach app