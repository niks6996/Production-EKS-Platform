# Cluster Autoscaler identity

Provides scoped EKS Pod Identity permissions for Cluster Autoscaler. Scaling
actions are restricted to auto scaling groups carrying this cluster's discovery tags.