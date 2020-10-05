## Terraform

[Linode](https://www.linode.com/products/kubernetes/) provides a fast and simple Kubernetes cluster deployments and they even recently started to update their terraform provider to support provisioning via [terraform](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lke_cluster)

## Structure of the files

This folder contains:

- `main.tf`
  - This file contains the required version of the provider and terraform
  - It also contains the required configuration of provider which is having token variable in this case
- `lke.tf`
  - This is the configuration of the cluster from [linode provider](https://registry.terraform.io/providers/linode/linode/latest/docs/resources/lke_cluster)
  - It gets the variables such as k8s version and create the nodes pool
- `vars.tf`
  - This file contains the variables
- `output.tf`
  - In order to see the `status`, `endpoint`, `id` and `pool` after the deployment, I have added them into output to see in the terminal.
  - Apart from that, to have a `kubeconfig` file for connecting to the cluster, I have added `kubeconfig` in the outfile as well. However, it would be highly recommended to hide the sensitive data from the terminal by adding `sensitive = true`.
- `secret.tfvars_example`
  - To avoid pushing the `*.tfvars` file, I have added `*.tfvars` into `.gitignore`. You need to rename this file to `secret.tfvars` and add your Linode Token there.

## Plan and Apply

Like other terraform codes, you need to plan and then apply it. However, since we are reading the token variable from the file, you need to perform following steps:

```
terraform plan -var-file="secret.tfvars"
```

```
terraform apply -var-file="secret.tfvars"
```
# Example of Terraform Plan

```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # linode_lke_cluster.assignment-cluster will be created
  + resource "linode_lke_cluster" "assignment-cluster" {
      + api_endpoints = (known after apply)
      + id            = (known after apply)
      + k8s_version   = "1.18"
      + kubeconfig    = (sensitive value)
      + label         = "home_assignment"
      + region        = "eu-west"
      + status        = (known after apply)
      + tags          = [
          + "home_assignment",
        ]

      + pool {
          + count = 1
          + id    = (known after apply)
          + nodes = (known after apply)
          + type  = "g6-standard-1"
        }
      + pool {
          + count = 1
          + id    = (known after apply)
          + nodes = (known after apply)
          + type  = "g6-standard-1"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

## Add K8s Config into your machine:

Since we added `kubeconfig` in `output.tf` we can export it with follwoing command:

```
export KUBE_VAR=`terraform output kubeconfig` && echo $KUBE_VAR | base64 -d > lke-linode-cluster-config.yaml
```
Above command will read the output and add it into `lke-linode-cluster-config.yaml` then we can can export `KUBECONFIG` and let it read the mentioned file by following command:

```
export KUBECONFIG=lke-linode-cluster-config.yaml
```