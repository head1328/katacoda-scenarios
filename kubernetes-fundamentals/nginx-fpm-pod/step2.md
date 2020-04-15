Deploy the NGINX PHP-FPM pod by running the command:

`kubectl apply -f step1/nginx-phpfpm-pod_example.yml`{{execute}}

In a moment the pod will be available.

`kubectl get deployments,pods,services`{{execute}}

Now that the application is running navigate to the [sample application](http://[[HOST_SUBDOMAIN]]-32500-[[KATACODA_HOST]].environments.katacoda.com/).
