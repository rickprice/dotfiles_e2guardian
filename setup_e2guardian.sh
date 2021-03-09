#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


## E2guardian
# +++ NOTICE +++ Wipe out existing e2guardian configuration!!!
if [[ -d /etc/e2guardian ]]
then
    sudo rm -rf /etc/e2guardian
fi
# +++ NOTICE +++ Wipe out existing e2guardian configuration!!!
# Put our e2guardian configuration in place
sudo ln -sf ~/.dotfiles/etc/e2guardian /etc/e2guardian

sudo useradd --system e2guardian

yay --noconfirm -S e2guardian

sudo systemctl stop e2guardian.service

### Certificate setup
e2MITMkeys=~/.dotfiles/etc/e2guardian/private
e2generatedcerts=~/.dotfiles/etc/e2guardian/private/generatedcerts
sudo mkdir -p $e2MITMkeys
sudo mkdir -p $e2generatedcerts
sudo chown e2guardian:e2guardian $e2MITMkeys
sudo chown e2guardian:e2guardian $e2generatedcerts

#### Generate a key for the rootCA
sudo openssl genrsa 4096 > $e2MITMkeys/private_root.pem
#### Generate the root CA certificate
sudo openssl req -new -x509 -days 3650 -key $e2MITMkeys/private_root.pem -out $e2MITMkeys/my_rootCA.crt
#### Create a DER format version of root certificate
sudo openssl x509 -in $e2MITMkeys/my_rootCA.crt -outform DER -out $e2MITMkeys/my_rootCA.der
#### Generate a key for use with upstream SSL conections
sudo openssl genrsa 4096 > $e2MITMkeys/private_cert.pem

sudo systemctl enable e2guardian.service
sudo systemctl start e2guardian.service
