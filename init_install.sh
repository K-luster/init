# install Extra Packages for Enterpries Linux System, Docker
sudo apt-get install epel-release -y
sudo apt-get install net-tools -y
sudo apt-get update && sudo apt-get -y upgrade

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update && sudo apt-get -y upgrade

# Install Kubernetes - kubectl, kubelet, kubeadm
sudo apt-get install -y kubelet=1.23.6-00 kubeadm=1.23.6-00 kubectl=1.23.6-00
sudo apt-mark hold kubelet kubeadm kubectl

echo "sleep 3 secs..."
sleep 3

sudo apt-get update && sudo apt-get upgrade

sudo systemctl daemon-reload
sudo systemctl restart kubelet

echo "Installing Docker..."
sudo curl -sSL https://get.docker.com/ | sh

echo "sleep 1 sec..."
sleep 1

echo "init_install.sh finished.. sleep 3 sec..."
sleep 3
