#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE=docker-compose.prod.yml

# ensure docker & docker-compose exists (optional check)
if ! command -v docker >/dev/null; then
  echo "docker not found. Install docker first."
  exit 1
fi

# Pull newest images and restart
docker compose -f "$COMPOSE_FILE" pull
docker compose -f "$COMPOSE_FILE" up -d --remove-orphans
docker compose -f "$COMPOSE_FILE" ps
