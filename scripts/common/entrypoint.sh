#!/bin/bash

set -e

# Try our best to normalize cgroups:
# - If we are sharing cgroup ns with the host, unshare
# - Ensure its mounted rw
current_cgroup=$(cat /proc/self/cgroup | cut -d ":" -f 3)
if [[ "$current_cgroup" == "/" ]]; then
  if ! findmnt -rn -O rw /sys/fs/cgroup >/dev/null; then
    # Root cgroup but mounted ro: remount
    exec /opt/assets/remount-cgroups.sh /opt/assets/startup.sh "$@"
  else
    # Root cgroup and rw, all good
    exec /opt/assets/startup.sh "$@"
  fi
else
  # Not a root group: unshare -> remount
  exec unshare -C /opt/assets/remount-cgroups.sh /opt/assets/startup.sh "$@"
fi
