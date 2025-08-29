#!/bin/sh

apt-get update && apt-get install cloudflared

echo "Host $REMOTE_HOST" >> $SSH_CONFIG_FILE
echo "    ProxyCommand cloudflared access ssh --hostname %h --id $CF_TUNNEL_ID --token $CF_TUNNEL_SECRET" >> $SSH_CONFIG_FILE

