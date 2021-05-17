#!/bin/bash

# Configure oidc-agent for user token management
echo "eval \`oidc-keychain\`" >> ~/.bashrc
eval `oidc-keychain`
oidc-gen dodas --issuer $IAM_SERVER \
               --client-id $IAM_CLIENT_ID \
               --client-secret $IAM_CLIENT_SECRET \
               --rt $REFRESH_TOKEN \
               --confirm-yes \
               --scope "openid profile email" \
               --redirect-uri  http://localhost:8843 \
               --pw-cmd "echo \"DUMMY PWD\""

while true; do oidc-token dodas --time 1200 > /tmp/token; sleep 600; done &
