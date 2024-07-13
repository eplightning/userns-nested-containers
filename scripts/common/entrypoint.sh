#!/bin/bash

set -e

current_cgroup=$(cat /proc/self/cgroup | cut -d ":" -f 3)

if [[ "$current_cgroup" == "/" ]]; then
  exec /opt/assets/startup.sh "$@"
else
  exec unshare -C /opt/assets/startup.sh "$@"
fi
