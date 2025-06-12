#!/bin/bash
set -e

echo "=== Minecraft Server Deployment Script ==="

# Check for required tools
for tool in terraform ansible aws ssh-keygen; do
  command -v $tool >/dev/null 2>&1 || { echo "$tool is required but not installed. Aborting." >&2; exit 1; }
done

# Define key paths
KEY_NAME="minecraftkey"
PRIVATE_KEY_PATH="$HOME/.ssh/$KEY_NAME"
PUBLIC_KEY_PATH="$HOME/.ssh/${KEY_NAME}.pub"

# Generate SSH key pair if missing
if [ ! -f "$PRIVATE_KEY_PATH" ] || [ ! -f "$PUBLIC_KEY_PATH" ]; then
  echo "SSH key pair not found. Generating new key pair..."
  ssh-keygen -t rsa -b 2048 -f "$PRIVATE_KEY_PATH" -N "" -q
else
  echo "Found existing SSH key pair."
fi

# Export variable so Terraform can use it
export TF_VAR_public_key_path="$PUBLIC_KEY_PATH"

# Deploy infrastructure
echo "Deploying infrastructure with Terraform..."
cd terraform
terraform init
terraform apply -auto-approve

# Get server IP
SERVER_IP=$(terraform output -raw minecraft_server_ip)
echo "Server IP: $SERVER_IP"

# Update Ansible inventory with the IP and key
cd ../ansible
sed -i "s/ansible_host: .*/ansible_host: $SERVER_IP/" inventory.yml
sed -i "s|ansible_private_key_file: .*|ansible_private_key_file: $PRIVATE_KEY_PATH|" inventory.yml

# Wait for server to be ready
echo "Waiting for server to be ready..."
sleep 60

# Run Ansible playbook
echo "Configuring server with Ansible..."
ansible-playbook -i inventory.yml minecraft-setup.yml

echo "=== Deployment Complete ==="
echo "Minecraft server is available at: $SERVER_IP:25565"
echo "Test connection with: nmap -sV -Pn -p T:25565 $SERVER_IP"
