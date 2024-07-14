#!/bin/bash

set -e

umount /sys/fs/cgroup
mount -o rw,relatime,nosuid,nodev,noexec -t cgroup2 cgroup2 /sys/fs/cgroup

exec "$@"