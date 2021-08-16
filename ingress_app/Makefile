
REGISTRY?="localhost:5000"


build:
	docker build -t $(REGISTRY)/webapp:1.0 .

run-local:
	docker run --rm -it -p 8080:8080 $(REGISTRY)/webapp:1.0

push:
	docker push $(REGISTRY)/webapp:1.0

deploy:
	kubectl apply -f ./manifests/
