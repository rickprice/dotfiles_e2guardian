#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


## E2guardian
if id e2guardian &>/dev/null; then
    echo 'user e2guardian already exists'
else
    sudo useradd --system e2guardian
fi

yay --noconfirm -S e2guardian

sudo systemctl stop e2guardian.service

### Certificate setup
e2MITMkeys=~/.dotfiles/etc/e2guardian/private
e2generatedcerts=~/.dotfiles/etc/e2guardian/private/generatedcerts
sudo mkdir -p $e2MITMkeys
sudo mkdir -p $e2generatedcerts
sudo chown -R e2guardian:e2guardian /etc/e2guardian
sudo chown -R e2guardian:e2guardian /var/log/e2guardian

# If MITM root key does not exist, then create new keys
 if [[ ! -f $e2MITMkeys/private_root.pem ]]
  then
    echo "The file ${FILE} does not exist!"
    #### Generate a key for the rootCA
    sudo openssl genrsa -out $e2MITMkeys/private_root.pem 4096 
    #### Generate the root CA certificate
    sudo openssl req -new -x509 -days 3650 -key $e2MITMkeys/private_root.pem -out $e2MITMkeys/my_rootCA.crt
    #### Trust the certificate we generated
    sudo trust anchor $e2MITMkeys/my_rootCA.crt
    #### Create a DER format version of root certificate
    sudo openssl x509 -in $e2MITMkeys/my_rootCA.crt -outform DER -out $e2MITMkeys/my_rootCA.der
    #### Generate a key for use with upstream SSL conections
    sudo openssl genrsa -out $e2MITMkeys/private_cert.pem 4096
  fi

sudo systemctl enable e2guardian.service
sudo systemctl start e2guardian.service

# Setup enviroment for proxy
sudo cp etc/environment /etc/environment

# +++ NOTICE +++ Wipe out existing e2guardian configuration!!!
# Put our e2guardian configuration in place
sudo cp -Rp etc/e2guardian/* /etc/e2guardian
# +++ NOTICE +++ Wipe out existing e2guardian configuration!!!
