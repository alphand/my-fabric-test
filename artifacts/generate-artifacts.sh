#!/usr/bin/env bash
set -euo pipefail

PATH=$PATH$(pwd)/../bin
echo $PATH

# Crypto Config setup
# chmod -R 0755 "${PWD}"/crypto-config || true
rm -rf "${PWD}"/crypto-config || true


#Generate Crypto artifactes for organizations
cryptogen generate --config=./cryptogen-setup/crypto-config.yaml --output=./crypto-config/