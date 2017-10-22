#!/bin/bash

# Check ip for cluster is in known hosts and add if neccessary
if [ -z "`ssh-keygen -F $1`" ]; then
  ssh-keyscan -H $1 >> ~/.ssh/known_hosts
else
  ssh-keygen -R $1
  ssh-keyscan -H $1 >> ~/.ssh/known_hosts
fi
 
# Fetch kube config from master
echo "Fetching Kubernetes config from remote server"
ssh -i $2 -o BatchMode=yes ubuntu@$1 'cat /home/ubuntu/.kube/config' > kube.config

# Parse kube config and extract certificates, certificates are base64 encoded
cat kube.config | sed -n -E 's/certificate-authority-data: "(.*)"/\1/p' | sed -e 's/^[ \t]*//' | base64 -D > cluster-ca-cert.pem

cat kube.config | sed -n -E 's/client-certificate-data: "(.*)"/\1/p' | sed -e 's/^[ \t]*//' | base64 -D > client-cert.pem

cat kube.config | sed -n -E 's/client-key-data: "(.*)"/\1/p' | sed -e 's/^[ \t]*//' | base64 -D > client-key.pem
