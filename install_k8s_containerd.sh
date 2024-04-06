# install k8s version >= 1.24
# containerd replaces docker

# install Extra Packages for Enterpries Linux System, Docker
sudo apt-get install epel-release -y
sudo apt-get install net-tools -y
sudo apt-get update && sudo apt-get -y upgrade

# Install Kubernetes Package
# Add Google Cloud Public GPG Key to apt
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add the repository to Apt sources:
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update

#remove conflicting packages with containerd, runc
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done


# Update APT Package and upgrade all package
# flag -y means all yes
sudo apt-get update && sudo apt-get -y upgrade

# make log dir
sudo mkdir -p logs

# Install containerd 1.6.30
echo "Install containerd 1.6.30"
sudo wget -o logs/containerd.log https://github.com/containerd/containerd/releases/download/v1.6.30/containerd-1.6.30-linux-amd64.tar.gz
sudo tar Cxzvf /usr/local containerd-1.6.30-linux-amd64.tar.gz

echo "containerd systemd"
sudo wget -o logs/containerd-systemd.log -P /usr/local/lib/systemd/system https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
sudo systemctl daemon-reload
sudo systemctl enable --now containerd

# Install Runc
echo "Install Runc"
sudo mkdir -p /usr/local/sbin/runc
sudo wget -o logs/runc.log https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

# Install CNI plugins
echo "Install CNI plugins"
sudo mkdir -p /opt/cni/bin
sudo wget -o logs/cni-plugins.log https://github.com/containernetworking/plugins/releases/download/v1.4.1/cni-plugins-linux-amd64-v1.4.1.tgz
sudo tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.4.1.tgz

# Install Kubernetes - kubelet, kubectl, kubeadm
# order : let -> ctl -> adm
echo "Install kubelet, kubectl, kubeadm"
sudo apt-get install -y kubelet=1.29.3-1.1 kubectl=1.29.3-1.1 kubeadm=1.29.3-1.1

# hold kubelet, kubectl, kubeadm version
echo "hold kubelet, kubectl, kubeadm"
sudo apt-mark hold kubelet kubectl kubeadm

echo "sleep 3 sec"
sleep 3

sudo apt-get update && sudo apt-get upgrade

sudo systemctl daemon-reload
sudo systemctl restart kubelet

echo "sleep 1 sec"
sleep 1
