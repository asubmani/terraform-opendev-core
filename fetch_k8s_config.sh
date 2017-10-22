#!/bin/bash

# Check ip for cluster is in known hosts and remove
if [ "`ssh-keygen -F $1`" ]; then
  ssh-keygen -R $1
fi

# Add new address to known hosts
ssh-keyscan -H $1 >> ~/.ssh/known_hosts

# Fetch kube config from master
echo "Fetching Kubernetes config from remote server"
ssh -i $2 -o BatchMode=yes ubuntu@$1 'cat /home/ubuntu/.kube/config' > kube.config

# Parse kube config and extract certificates, certificates are base64 encoded
cat kube.config | sed -n -E 's/certificate-authority-data: "(.*)"/\1/p' | sed -e 's/^[ \t]*//' | base64 -D > cluster-ca-cert.pem
cat kube.config | sed -n -E 's/client-certificate-data: "(.*)"/\1/p' | sed -e 's/^[ \t]*//' | base64 -D > client-cert.pem
cat kube.config | sed -n -E 's/client-key-data: "(.*)"/\1/p' | sed -e 's/^[ \t]*//' | base64 -D > client-key.pem
