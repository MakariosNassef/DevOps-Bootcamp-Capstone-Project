output "OIDC_MODULE" {
  value = module.cluster_module.OIDC_OUT
}

output "INSTANCE_PUBLIC_IP_OUTPUT_MODULE" {
  value = module.instance_module.INSTANCE_PUBLIC_IP
}
