resource "aws_instance" "mke-manager" {
  count                       = var.manager_count
  ami                         = var.nodeami
  instance_type               = var.instancetype
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.sshkeypair
  user_data                   = <<EOF
#!/bin/sh
HOSTNAME="${var.hostname_prefix}${count.index+1}"
echo $HOSTNAME > /etc/hostname
sudo sed -i "s|please-wait-while-node-initializes|$HOSTNAME|g" /etc/hosts
sudo hostname $HOSTNAME
sudo echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL "https://repos.mirantis.com/ubuntu/gpg" | sudo apt-key add -
sudo add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://repos.mirantis.com/ubuntu $(lsb_release -cs) stable-${var.DOCKER_EE_VERSION}"
sudo apt-get update
sudo apt-get -y install docker-ee docker-ee-cli containerd.io
sudo reboot
EOF

  root_block_device {
    volume_type = "gp2"
    volume_size = var.manager_volume_size
  }
}