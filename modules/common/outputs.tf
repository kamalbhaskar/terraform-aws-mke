output "sshkeypair" {
  value = aws_key_pair.mkelabKey.key_name
}

output "security_group_id" {
  value = aws_security_group.mkelabSG.id
}

output "subnet_id" {
  value = aws_subnet.mkelabSubnet.id
}
