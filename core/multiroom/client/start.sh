#!/usr/bin/env bash
set -e

# --- ENV VARS ---
# SOUND_MULTIROOM_LATENCY: latency in milliseconds to compensate for speaker hardware sync issues
LATENCY=${SOUND_MULTIROOM_LATENCY:+"--latency $SOUND_MULTIROOM_LATENCY"}

echo "Starting multi-room client..."
echo "Mode: $MODE"
echo "Target snapcast server: $SNAPSERVER"

# Start snapclient
if [[ "$MODE" == "MULTI_ROOM" || "$MODE" == "MULTI_ROOM_CLIENT" ]]; then
  # Start snapclient and filter out those pesky chunk logs
  # grep filter can be removed when we get snapcast v0.20
  # see: https://github.com/badaix/snapcast/issues/559#issuecomment-615874719
  /usr/bin/snapclient --host $SNAPSERVER $LATENCY | grep -v "\[Info\] (Stream) Chunk"
else
  echo "Multi-room client disabled. Exiting..."
  exit 0
fi