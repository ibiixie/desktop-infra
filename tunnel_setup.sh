#!/bin/sh

# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared noble main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# Install cloudflared
sudo apt-get update && sudo apt-get install cloudflared

# Setup SSH dir and config perms
echo Setting up SSH directory and config
mkdir -p /root/.ssh
touch /root/.ssh/config
chmod 600 /root/.ssh/config
chmod 700 /root/.ssh

# Add SSH ProxyCommand for cloudflared
echo Added ProxyCommand to config at $SSH_CONFIG_FILE
echo "Host $REMOTE_HOST" >> $SSH_CONFIG_FILE
echo "    ProxyCommand cloudflared access ssh --hostname %h --id $CF_TUNNEL_ID --token $CF_TUNNEL_SECRET" >> $SSH_CONFIG_FILE

