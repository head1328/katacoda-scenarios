For this scenario, Katacoda has just started a fresh Kubernetes cluster for you. Now wait until your environment is initialized and verify it's ready for your use.

`kubectl version --short && \
kubectl get componentstatus && \
kubectl get nodes && \
kubectl cluster-info`{{execute}}

The [Helm](https://helm.sh/) package manager used for installing applications on Kubernetes is also available.

`helm version --short`{{execute}}

## Kubernetes Dashboard ##

You can administer your cluster with the `kubectl` CLI tool or use the visual Kubernetes Dashboard. Use this script to access the protected Dashboard.

`token.sh`{{execute}}

## Docker registry ##

The registry is available as a service. It can be listed.

`kubectl get service --namespace kube-system && \
kubectl get deployments private-docker-registry --namespace kube-system && \
curl $REGISTRY/v2/_catalog`{{execute}}

## Sample PHP application ##

Build the sample appication:

`docker build -f ./step1/Dockerfile -t $REGISTRY/php-app:latest ./step1 && \
docker push $REGISTRY/php-app:latest && \
curl $REGISTRY/v2/_catalog`{{execute}}
