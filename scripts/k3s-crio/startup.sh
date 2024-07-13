#!/bin/bash

set -e

bash /opt/assets/setup-cgroups.sh

if [[ "$1" != "server" ]]; then
  exec "$@"
fi

shift

k3s_args=(
  "server"
  "--cluster-cidr" "192.168.96.0/22"
  "--service-cidr" "192.168.100.0/22"
  "--flannel-backend" "none"
  "--kubelet-arg" "feature-gates=KubeletInUserNamespace=true"
  "--container-runtime-endpoint" "/var/run/crio/crio.sock"
  "--disable" "traefik"
)
k3s_args+=( "$@" )

(_CRIO_ROOTLESS=1 setsid crio &)
(setsid bash /opt/assets/setup-manifests.sh &)

exec k3s "${k3s_args[@]}"
