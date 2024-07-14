#!/bin/bash

set -e

umount /sys/fs/cgroup
mount -o rw,relatime,nosuid,nodev,noexec -t cgroup2 none /sys/fs/cgroup

exec "$@"