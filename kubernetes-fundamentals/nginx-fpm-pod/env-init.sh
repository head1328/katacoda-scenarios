#!/bin/sh

launch.sh

# Helm setup
HELM_VERSION=v3.1.2
curl -fsSL https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz | tar -zxvf - -C /usr/local/bin/ linux-amd64/helm --strip=1
helm repo add stable https://kubernetes-charts.storage.googleapis.com/

# Setup dashboard on port 30000
helm install dash stable/kubernetes-dashboard \
--namespace kube-system \
--set=service.type=NodePort \
--set=enableInsecureLogin=true \
--set=service.nodePort=30000 \
--set=service.externalPort=80

# Setup registry on port 31500
REGISTRY_VERSION=2.7.1
helm install private stable/docker-registry \
--namespace kube-system \
--set image.tag=$REGISTRY_VERSION \
--set service.type=NodePort \
--set service.nodePort=31500

sleep 1m

kubectl port-forward --namespace kube-system \
$(kubectl get po -n kube-system | grep private-docker-registry | \
awk '{print $1;}') 5000:5000 &

export REGISTRY=127.0.0.1:31500

source <(kubectl completion bash)
source <(helm completion bash)

{ clear && echo 'Kubernetes with Helm is ready.'; } 2> /dev/null
