Deploy the NGINX PHP-FPM pod by running the command:

`kubectl apply -f files/nginx-phpfpm-pod_example-2.yml`{{execute}}

In a moment the pod will be available.

`kubectl get deployments,pods,services,configmaps`{{execute}}

Now that the application is running navigate to the [sample application](http://[[HOST_SUBDOMAIN]]-33500-[[KATACODA_HOST]].environments.katacoda.com/).
