#!/bin/bash
CURL_QRY="-s https://mempool.space/api/blocks/tip/height"
CURL_OUT=$(curl $CURL_QRY)
echo "Blocks"
echo $CURL_OUT 
CURL_QRY="-s https://bitcoinexplorer.org/api/blocks/tip"
CURL_OUT=$(curl $CURL_QRY)
echo $CURL_OUT 
CURL_QRY="-s https://bitcoinexplorer.org/api/blockchain/coins"
CURL_OUT=$(curl $CURL_QRY)
echo "Supply"
echo $CURL_OUT