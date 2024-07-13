#!/bin/bash

set -e

mkdir /sys/fs/cgroup/init
xargs -rn1 < /sys/fs/cgroup/cgroup.procs > /sys/fs/cgroup/init/cgroup.procs || true
sed -e 's/ / +/g' -e 's/^/+/' < "/sys/fs/cgroup/cgroup.controllers" > "/sys/fs/cgroup/cgroup.subtree_control"
