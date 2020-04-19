# NGINX and PHP-FPM pods on Kubernetes

NGINX and PHP-FPM need to have access to the same files on the filesystem. In Kubernetes, this means they need to be running on the same pod, and we’ll use a volume to share files between the two containers.

I have found two solutions and would like to show how they differ from each other:

What both solution have in common:

* the official NGINX alpine Docker image using alpine with the application code under `/app`
* a custom PHP-FPM image basen on the offical PHP-FPM alpine Docker image
* a ConfigMap as a volume for the NGINX pod
* a shared files volume to be used in both pods

The Problem: After the container has started, the PHP files in our Docker image aren't in the shared volume. We need to get them into the shared volume. If we tried to write directly to this volume from our Docker image the files wouldn't appear in the NGINX container.

## Solution 1:

With lifecycles it is possible to copy our application code to the shared volume on post start. Possible disadvantage: traffic before copy process has finished.

## Solution 2:

Instead of using lifecycles we use an init container for copying our files.