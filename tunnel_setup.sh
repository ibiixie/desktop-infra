#!/bin/sh

# Add cloudflare gpg key
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null

# Add this repo to your apt repositories
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared noble main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# Install cloudflared
sudo apt-get update && sudo apt-get install cloudflared

# Add SSH ProxyCommand for cloudflared
echo "Host $REMOTE_HOST" >> $SSH_CONFIG_FILE
echo "    ProxyCommand cloudflared access ssh --hostname %h --id $CF_TUNNEL_ID --token $CF_TUNNEL_SECRET" >> $SSH_CONFIG_FILE

