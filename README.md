# terraform-linode-k8s

## About
This project creates a cluster on [Linode](https://www.linode.com/products/kubernetes/) and provisioning it via [terraform](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lke_cluster).

It also contains manfiest to deploy [`prom-http-simulator`](https://hub.docker.com/r/pierrevincent/prom-http-simulator/) for exposing metrics and `prometheus` for monitoring .

## Structure
- `infrastructure` : This folder contains the `terraform` files for provisioning cluster
- `k8s` : This directory contains the `k8s` manifest
    - `app` : Manifest file of [`prom-http-simulator`](https://hub.docker.com/r/pierrevincent/prom-http-simulator/)
    - `prometheus` : Manifest file for deploying `prometheus`
    - `prometheus` : Manifest file for deploying `prometheus`
    - `alertmanager` : Manifest file for deploying `alertmanager`
    - `k8sconfig` : Manifest file for configuring `namespace` and `ClusterRole`
## Getting Started
Please make sure that you have already `kubectl` and `git` installed.

For Mac Users:

If you want to use `Makefile`of this project, please run `brew install gettext`in order to have `envsubst`.


## How To Use
In order to use this repository, you need to deploy the `infrastructure` first. That way you will have your cluster on Linode. After that, you can deploy the application and prometheus from `k8s` directory. Each directory has the Readme file that contains required information.

### How To Access

When you deploy the application, it is available in Port 8080. Thus, as mentioned in [`prom-http-simulator` documentation] (https://hub.docker.com/r/pierrevincent/prom-http-simulator), you can start running the `curl` command turn on spike and off or even sending random load to the service.

Example:

Setting Error Rate to 50%:

```
curl -H 'Content-Type: application/json' -X PUT -d '{"error_rate": 50}' http://212.71.236.119:8080/error_rate
```

In Above example, my IP Address is `212.71.236.119`.

Apart from the application it self, you can have access to `prometheus` from your brwoser by going to `http://IP:9090`. In my example, `prometheus` is accessible via `http://185.3.92.242:9090/`

## Known Issue
At the time of writing this Readme I haven't found any issues. However, since it stays opensource I would like to see your feedback as an issue on this repository and even feel free to raise a pull request.

## Licensing
This project is licensed under Unlicense license.