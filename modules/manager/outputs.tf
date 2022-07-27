output "manager_public_ips" {
  value = aws_instance.mke-manager.*.public_ip
  description = "PublicIP address details for manager node(s)"
}