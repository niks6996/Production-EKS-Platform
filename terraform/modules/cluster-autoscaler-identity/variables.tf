variable "cluster_name" {
  type = string
}
variable "role_name" {
  type = string
}
variable "namespace" {
  type    = string
  default = "kube-system"
}
variable "service_account" {
  type = string
}
variable "tags" {
  type    = map(string)
  default = {}
}