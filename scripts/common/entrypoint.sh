#!/bin/bash

set -e

current_cgroup=$(cat /proc/self/cgroup | cut -d ":" -f 3)

if [[ "$current_cgroup" == "/" ]]; then
  exec /opt/assets/startup.sh "$@"
else
  # Privileged pods in Kubernetes share cgroup namespace with the host
  # This is not something we want so we unshare it and then remount /sys/fs/cgroup
  exec unshare -C /opt/assets/remount-cgroups.sh /opt/assets/startup.sh "$@"
fi
