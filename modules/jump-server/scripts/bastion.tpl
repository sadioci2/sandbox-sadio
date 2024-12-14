#!/bin/bash

# Install necessary tools
sudo apt update
sudo apt install -y sshpass

# Add the private key for SSH
echo "${key_pair_content}" > /home/ubuntu/bastion_key.pem
chmod 400 /home/ubuntu/bastion_key.pem

# Add the private instance's IP to known hosts
ssh-keyscan -H ${private_ip} >> ~/.ssh/known_hosts
