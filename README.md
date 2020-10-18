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


## Known Issue
At the time of writing this Readme I haven't found any issues. However, since it stays opensource I would like to see your feedback as an issue on this repository and even feel free to raise a pull request.

## Licensing
This project is licensed under Unlicense license.