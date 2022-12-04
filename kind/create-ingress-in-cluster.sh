#!/bin/sh
set -o errexit

echo '------- ------- ------- ------- ------- '
echo '------- Creating Ingress Resources!'
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
echo '------- '

#echo '------- ------- ------- ------- ------- '
#echo '------- Waiting the creation of Ingress resources '
#kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=180s
#echo '------- '

