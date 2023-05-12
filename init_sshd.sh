sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo systemctl restart ssh

echo "init_sshd.sh finished.. sleep 1 sec..."
sleep 1