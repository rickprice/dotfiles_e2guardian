#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Remove proxy settings for the moment
unset http_proxy
unset https_proxy
unset all_proxy

## Now run the git pull
git pull

sudo systemctl stop e2guardian.service

# Setup enviroment for proxy
sudo cp etc/environment /etc/environment

# +++ NOTICE +++ Wipe out existing e2guardian configuration!!!
# Put our e2guardian configuration in place
sudo cp -Rp etc/e2guardian/* /etc/e2guardian
# +++ NOTICE +++ Wipe out existing e2guardian configuration!!!

sudo chown -R e2guardian:e2guardian /etc/e2guardian
sudo chown -R e2guardian:e2guardian /var/log/e2guardian

sudo systemctl enable e2guardian.service
sudo systemctl start e2guardian.service
