
CLUSTER_NAME?=kind-kind

create-cluster:
	sh ./kind/create-kind-multinode.sh

delete-cluster:
	kind delete cluster
	docker stop kind-registry

kind-set-context:
	kubectl cluster-info --context $(CLUSTER_NAME)
	kubectl config use-context $(CLUSTER_NAME)

