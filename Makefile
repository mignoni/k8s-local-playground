
CLUSTER_NAME?="kind-kind"
REGISTRY?="localhost:5000"

create-cluster:
	sh ./kind/create-kind-multinode.sh

delete-cluster:
	kind delete cluster
	docker stop kind-registry

kind-set-context:
	kubectl cluster-info --context $(CLUSTER_NAME)
	kubectl config use-context $(CLUSTER_NAME)

list-repos:
	curl "$(REGISTRY)/v2/_catalog"

create-ingress-controller:
	kubectl apply -f https://github.com/datawire/ambassador-operator/releases/latest/download/ambassador-operator-crds.yaml
	kubectl apply -n ambassador -f https://github.com/datawire/ambassador-operator/releases/latest/download/ambassador-operator-kind.yaml
	kubectl wait --timeout=180s -n ambassador --for=condition=deployed ambassadorinstallations/ambassador

