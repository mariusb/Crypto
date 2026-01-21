#!/bin/bash
echo "#BTC - VALR in #SouthAfrica"
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/BTCZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo $VALR_PRICE
echo "#ETH - VALR in #SouthAfrica"
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/ETHZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo $VALR_PRICE
echo "#USDT - VALR in #SouthAfrica"
CURL_QRY="-s --location --request GET https://api.valr.com/v1/public/USDTZAR/marketsummary"
CURL_OUT=$(curl $CURL_QRY)
VALR_PRICE=$(echo $CURL_OUT | jq '.lastTradedPrice | tonumber')
echo $VALR_PRICE

echo "======================="
CURL_QRY="-s https://openexchangerates.org/api/latest.json?app_id=3263b0c93523446299d17e2e6abdd748&symbols=ZAR"
CURL_OUT=$(curl $CURL_QRY)
USDZAR_RATE=$(echo $CURL_OUT | jq '.rates.ZAR | tonumber')
echo "<=== USD/ZAR Rate ===>" 
echo $USDZAR_RATE

echo $(date)
#echo "https://tippin.me/@mariusb"