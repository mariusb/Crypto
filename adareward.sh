#!/bin/bash
CURL_QRY="--header project_id:JiMBViccGs6Rh2ovpoQRDFlhFLb82HxO -s https://cardano-mainnet.blockfrost.io/api/v0/epochs/latest"
CURL_OUT=$(curl $CURL_QRY)
echo "Latest epoch"
echo $CURL_OUT | jq . 
CURL_QRY="--header project_id:JiMBViccGs6Rh2ovpoQRDFlhFLb82HxO -s https://cardano-mainnet.blockfrost.io/api/v0/accounts/stake1u95sqsystynh9w62420wkw9cptm3zv5km7fwxc0scjnsv0gd8qhra"
CURL_OUT=$(curl $CURL_QRY)
echo "Ledger Nano S"
echo $CURL_OUT | jq . 
CURL_QRY="--header project_id:JiMBViccGs6Rh2ovpoQRDFlhFLb82HxO -s https://cardano-mainnet.blockfrost.io/api/v0/accounts/stake1u9rve5y8vk2gxnvq7m382wh3kpcrzgus6epfjkhc55y9cwcxqd0we"
CURL_OUT=$(curl $CURL_QRY)
echo "Non Hardware Wallet"
echo $CURL_OUT | jq . 
CURL_QRY="--header project_id:JiMBViccGs6Rh2ovpoQRDFlhFLb82HxO -s https://cardano-mainnet.blockfrost.io/api/v0/accounts/stake1u9yps06nf0k3qandlt7fft70xluh2hlu6rqp9ue5ffcsdkgfs2qz0"
CURL_OUT=$(curl $CURL_QRY)
echo "Tokens and NFT's"
echo $CURL_OUT | jq . 
