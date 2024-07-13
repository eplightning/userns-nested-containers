#!/bin/bash

set -e

while [[ ! -d "/var/lib/rancher/k3s/server/manifests" ]]; do
  echo "Waiting for /var/lib/rancher/k3s/server/manifests ..."
  sleep 3
done

echo "Copying custom manifests to /var/lib/rancher/k3s/server/manifests"

cp -r /opt/assets/manifests/* /var/lib/rancher/k3s/server/manifests/