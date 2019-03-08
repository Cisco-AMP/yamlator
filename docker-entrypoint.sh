#!/bin/sh

set -e
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec tail -f /dev/null
