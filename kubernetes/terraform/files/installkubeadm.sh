#!/bin/bash
sudo apt update 
# sudo apt -y full-upgrade [ -f /var/run/reboot-required ] && sudo reboot -f

#add k8s mirror
echo "install apt-transport-https"
sudo apt -y install curl apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

#Install kubeadm
echo "Install kubeadm"
sudo apt update
sudo apt-get install -y kubeadm=1.27.2-00
sudo apt -y install vim git curl wget kubelet kubectl
sudo apt-mark hold kubelet kubeadm kubectl
#Confirm install
kubectl version --client && kubeadm version

#disable swap
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
swapoff -a
# Enable kernel modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Add some settings to sysctl
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Reload sysctl
sudo sysctl --system
