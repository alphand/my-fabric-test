#!/usr/bin/env bash
set -euo pipefail

PATH=$PATH$(pwd)/../bin
# echo $PATH

# Crypto Config setup
# chmod -R 0755 "${PWD}"/crypto-config || true
rm -rf "${PWD}"/crypto-config || true


#Generate Crypto artifactes for organizations
cryptogen generate --config=./cryptogen-setup/crypto-config.yaml --output=./crypto-config/


# SYSTEM CHANNEL
SYS_CHANNEL="sys-channel"

CHANNEL_NAME="mychannel"

configtxgen -profile OrdererGenesis -configPath ./channel -channelID $SYS_CHANNEL -outputBlock ./lib/genesis.block
configtxgen -profile BasicChannel -configPath ./channel -outputCreateChannelTx ./lib/my-channel.tx -channelID $CHANNEL_NAME

configtxgen -profile BasicChannel -configPath ./channel \
  -outputAnchorPeersUpdate ./lib/sales-org-msp-anchors.tx -channelID $CHANNEL_NAME \
  -asOrg SalesOrgMSP

configtxgen -profile BasicChannel -configPath ./channel \
  -outputAnchorPeersUpdate ./lib/contract-org-msp-anchors.tx -channelID $CHANNEL_NAME \
  -asOrg ContractOrgMSP