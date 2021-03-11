#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

#@ Remove proxy settings for the moment
unset http_proxy
unset https_proxy
unset all_proxy

## Now run the git pull
git pull
