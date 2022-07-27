output "worker_public_ips" {
  value = aws_instance.mke-worker.*.public_ip
  description = "PublicIP address details for worker node(s)"
}