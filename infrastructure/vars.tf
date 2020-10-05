variable "token" {
    description = "The token to use for deploying Linode infrastructure"
}

variable "k8s_version"{
    description = "The Kubernetes version to use for this cluster"
    default = "1.18"    
}

variable "label" {
    default = "home_assignment"
}

variable "tags" {
  description = "Tags to apply to your cluster for organizational purposes"
  type = list(string)
  default = ["home_assignment"]
}

variable "region" {
    default = "eu-west"
}
 
variable "pools" {
    description = "The Node Pool specifications for the Kubernetes cluster"
    type = list(object({
    type = string
    count = number
    }))
    default = [
    {
        type = "g6-standard-1"
        count = 1
    },
    {
        type = "g6-standard-1"
        count = 1
    }
    ]
}
    