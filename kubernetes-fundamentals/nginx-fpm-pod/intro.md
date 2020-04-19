# NGINX and PHP-FPM pods on Kubernetes

NGINX and PHP-FPM need to have access to the same files on the filesystem. In Kubernetes, this means they need to be running on the same pod, and we’ll use a volume to share files between the two containers.

I have found two solutions and would like to show how they differ from each other:

What both solutions have in common:

* the official NGINX alpine Docker image using alpine with the application code under `/app`
* a custom PHP-FPM image based on the offical PHP-FPM alpine Docker image
* a ConfigMap as a volume for the NGINX pod
* a shared files volume to be used in both pods

The Problem: After the containers have started, the PHP files in our Docker image aren't in the shared volume. We need to get them into the shared volume. If we tried to write directly to this volume from our Docker image build the files wouldn't appear in the NGINX container.

## Solution 1:

With lifecycles it is possible to copy our application code to the shared volume on post start.

Possible disadvantages:

* traffic before copy process has finished
* it will take longer before our pod is reachable if you have many files to copy first.

## Solution 2:

Instead of copying create a symlink. Because we no longer have to copy files, we no longer have these disadvantages compared to solution 1. Now, in addition the kubelet uses readiness probes to know when a container is ready to start accepting traffic.

Note: there was a [security issue](https://kubernetes.io/blog/2018/04/04/fixing-subpath-volume-vulnerability/).