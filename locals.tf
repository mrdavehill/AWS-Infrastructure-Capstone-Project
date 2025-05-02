locals {
  namespace = [for v in var.kubernetes : v.namespace]
  project   = [for v in var.kubernetes : v.project]
}