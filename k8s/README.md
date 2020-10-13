## Kubernetes manifests files

We have two different directories here. `app`  directory contains the manifest files of the application and `prometheus` contains the manifest files of the the monitoring.

We do have different namespace for application and monitoring and that is why you will see a `namespace.yml` file in both of them.

## Deployment

In general, to deploy either of directories we can directlz use `kubectl apply -f .` by navigating into the directory itself. However, since application and monitoring are running in different namespace, we have to apply the namespace manifest first by `kubectl apply -f namespace.yml` .

## Makefile
