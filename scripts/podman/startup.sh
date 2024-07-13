#!/bin/bash

set -e

bash /opt/assets/setup-cgroups.sh

(setsid podman system service --time 0 unix:///var/run/podman/podman.sock &)

exec "$@"
