#!/usr/bin/env bash
swapoff -a && sed -i '/swap/s/^/#/' /etc/fstab

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables=1
net.bridge.bridge-nf-call-iptables=1
EOF
sudo sysctl --system

echo "192.168.2.10 m-k8s" >> /etc/hosts
for (( i=1; i<=$1; i++ )); do echo "192.168.2.10$i w$i-k8s" >> /etc/hosts; done