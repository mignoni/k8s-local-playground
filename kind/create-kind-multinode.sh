#!/bin/bash
set -o errexit

# create registry container unless it already exists
reg_name='kind-registry'
reg_port='5000'
running="$(docker inspect -f '{{.State.Running}}' "${reg_name}" 2>/dev/null || true)"
registry_exists="$(docker ps -a -f 'name=kind-registry' | wc -l)"
if [ "${running}" != 'true' ]; then
  echo 'Registry is not running!'
  if [ "${registry_exists}" -gt 1 ]; then
    echo 'Starting existing container registry'
    docker start "${reg_name}"
  else
    echo 'Creating a container registry'
    docker run -d -p "${reg_port}:5000" --name "${reg_name}" registry:2
  fi
fi

# create a cluster with the local registry enabled in containerd
echo 'Creating a k8s cluster with multiple nodes'
kind create cluster --config=./kind/kind-multinode-config.yaml

# connect the registry to the cluster network
if ! [ "${registry_exists}" -gt 1 ]; then
  docker network connect "kind" "${reg_name}"
fi

# tell https://tilt.dev to use the registry
# https://docs.tilt.dev/choosing_clusters.html#discovering-the-registry
for node in $(kind get nodes); do
  kubectl annotate node "${node}" "kind.x-k8s.io/registry=localhost:${reg_port}";
done

