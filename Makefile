
CLUSTER_NAME?="kind-kind"
REGISTRY?="localhost:5001"

create-cluster-all: create-cluster create-ingress-controller

create-cluster:
	sh ./kind/create-kind-cluster.sh

create-ingress-controller:
	sh ./kind/create-ingress-in-cluster.sh

delete-cluster:
	kind delete cluster
	docker stop kind-registry

kind-set-context:
	kubectl cluster-info --context $(CLUSTER_NAME)
	kubectl config use-context $(CLUSTER_NAME)

list-repos:
	curl "$(REGISTRY)/v2/_catalog"



