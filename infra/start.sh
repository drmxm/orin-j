#!/usr/bin/env bash
set -Eeuo pipefail
set +u
source /opt/ros/humble/setup.bash
set -u

FOXGLOVE_PORT="${FOXGLOVE_PORT:-8765}"
echo "[infra] Foxglove ws://0.0.0.0:${FOXGLOVE_PORT}"

sleep 1
exec ros2 run foxglove_bridge foxglove_bridge \
  --address 0.0.0.0 \
  --port "${FOXGLOVE_PORT}"